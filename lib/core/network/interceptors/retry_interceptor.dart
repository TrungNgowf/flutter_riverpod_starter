import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

/// Configuration for retry behavior
class RetryConfig {
  /// Maximum number of retry attempts
  final int maxRetries;

  /// Initial delay before first retry
  final Duration initialDelay;

  /// Maximum delay between retries
  final Duration maxDelay;

  /// Multiplier for exponential backoff
  final double backoffMultiplier;

  /// HTTP status codes that should trigger a retry
  final Set<int> retryStatusCodes;

  /// HTTP methods that are safe to retry
  final Set<String> retryMethods;

  const RetryConfig({
    this.maxRetries = 3,
    this.initialDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.retryStatusCodes = const {408, 429, 500, 502, 503, 504},
    this.retryMethods = const {'GET', 'HEAD', 'OPTIONS', 'DELETE'},
  });

  /// Default configuration for most use cases
  static const RetryConfig defaultConfig = RetryConfig();

  /// Aggressive retry configuration
  static const RetryConfig aggressive = RetryConfig(
    maxRetries: 5,
    initialDelay: Duration(milliseconds: 200),
    maxDelay: Duration(seconds: 60),
  );

  /// Conservative retry configuration
  static const RetryConfig conservative = RetryConfig(
    maxRetries: 2,
    initialDelay: Duration(seconds: 1),
    maxDelay: Duration(seconds: 10),
  );
}

/// Interceptor that handles automatic retries for failed requests
/// Uses exponential backoff with jitter
class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final RetryConfig _config;

  RetryInterceptor({
    required Dio dio,
    RetryConfig config = RetryConfig.defaultConfig,
  }) : _dio = dio,
       _config = config;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;

    // Check if we should retry
    if (!_shouldRetry(err, retryCount)) {
      return handler.next(err);
    }

    // Calculate delay with exponential backoff and jitter
    final delay = _calculateDelay(retryCount);

    // Wait before retrying
    await Future.delayed(delay);

    // Update retry count
    err.requestOptions.extra['retryCount'] = retryCount + 1;

    try {
      // Retry the request
      final response = await _dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (e) {
      // If retry fails, call onError again (may trigger another retry)
      return onError(e, handler);
    }
  }

  /// Determine if the request should be retried
  bool _shouldRetry(DioException err, int retryCount) {
    // Check if we've exceeded max retries
    if (retryCount >= _config.maxRetries) {
      return false;
    }

    // Check if this method is safe to retry
    final method = err.requestOptions.method.toUpperCase();
    if (!_config.retryMethods.contains(method)) {
      // POST/PUT/PATCH can be retried only for specific errors
      if (!_isIdempotentError(err)) {
        return false;
      }
    }

    // Check error type
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return true;

      case DioExceptionType.connectionError:
        return true;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        return statusCode != null &&
            _config.retryStatusCodes.contains(statusCode);

      case DioExceptionType.unknown:
        // Retry on socket exceptions (network issues)
        return err.error is SocketException;

      default:
        return false;
    }
  }

  /// Check if the error indicates the request never reached the server
  /// (making it safe to retry even for non-idempotent methods)
  bool _isIdempotentError(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError;
  }

  /// Calculate delay using exponential backoff with jitter
  Duration _calculateDelay(int retryCount) {
    // Exponential backoff: initialDelay * (backoffMultiplier ^ retryCount)
    final exponentialDelay =
        _config.initialDelay.inMilliseconds *
        pow(_config.backoffMultiplier, retryCount);

    // Add jitter (±25%)
    final jitter = Random().nextDouble() * 0.5 - 0.25;
    final delayWithJitter = exponentialDelay * (1 + jitter);

    // Clamp to max delay
    final clampedDelay = min(
      delayWithJitter.toInt(),
      _config.maxDelay.inMilliseconds,
    );

    return Duration(milliseconds: clampedDelay);
  }
}
