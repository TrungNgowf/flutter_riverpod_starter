import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter/core/logging/app_logger.dart';

/// Interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  final AppLogger _logger;
  final bool _logRequestBody;
  final bool _logResponseBody;
  final bool _logHeaders;
  final Set<String> _sensitiveHeaders;

  LoggingInterceptor({
    required AppLogger logger,
    bool logRequestBody = true,
    bool logResponseBody = true,
    bool logHeaders = false,
    Set<String>? sensitiveHeaders,
  })  : _logger = logger,
        _logRequestBody = logRequestBody,
        _logResponseBody = logResponseBody,
        _logHeaders = logHeaders,
        _sensitiveHeaders = sensitiveHeaders ??
            {
              'authorization',
              'cookie',
              'set-cookie',
              'x-api-key',
            };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('[HTTP] ${options.method} ${options.uri}');

    if (_logHeaders && options.headers.isNotEmpty) {
      for (final entry in options.headers.entries) {
        final key = entry.key;
        final value = _sanitizeHeader(key, entry.value);
        _logger.debug('[HTTP] header $key: $value');
      }
    }

    if (_logRequestBody && options.data != null) {
      _logger.debug('[HTTP] body: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.debug(
      '[HTTP] ${response.statusCode} ${response.requestOptions.uri} '
      '(${_getDuration(response.requestOptions)})',
    );

    if (_logHeaders && response.headers.map.isNotEmpty) {
      for (final entry in response.headers.map.entries) {
        final key = entry.key;
        final value = _sanitizeHeader(key, entry.value.join(', '));
        _logger.debug('[HTTP] header $key: $value');
      }
    }

    if (_logResponseBody && response.data != null) {
      _logger.debug('[HTTP] body: ${response.data}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      '[HTTP] ${err.type} ${err.requestOptions.uri} '
      '(${err.response?.statusCode ?? 'no-status'}) '
      '${err.message ?? ''}'.trim(),
      err,
    );

    if (_logHeaders && err.response?.headers.map != null) {
      for (final entry in err.response!.headers.map.entries) {
        final key = entry.key;
        final value = _sanitizeHeader(key, entry.value.join(', '));
        _logger.error('[HTTP] header $key: $value');
      }
    }

    if (_logResponseBody && err.response?.data != null) {
      _logger.error('[HTTP] body: ${err.response?.data}');
    }

    handler.next(err);
  }

  /// Get request duration (if available)
  String _getDuration(RequestOptions options) {
    final startTime = options.extra['startTime'] as DateTime?;
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      return '${duration.inMilliseconds}ms';
    }
    return 'N/A';
  }

  String _sanitizeHeader(String key, dynamic value) {
    if (_sensitiveHeaders.contains(key.toLowerCase())) {
      return '[REDACTED]';
    }
    return value.toString();
  }
}

/// Interceptor to track request timing
class TimingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now();
    handler.next(options);
  }
}
