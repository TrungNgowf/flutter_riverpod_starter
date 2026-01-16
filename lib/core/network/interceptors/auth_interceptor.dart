import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter/core/network/endpoints.dart';
import 'package:flutter_riverpod_starter/core/network/token_manager/token_manager.dart';

/// Interceptor that handles authentication
/// - Adds access token to requests
/// - Handles token refresh on 401 errors
/// - Queues requests during token refresh
class AuthInterceptor extends QueuedInterceptor {
  final TokenManager _tokenManager;
  final Future<void> Function()? _onTokenRefresh;
  final void Function()? _onLogout;

  bool _isRefreshing = false;
  final _pendingRequests =
      <({RequestOptions options, ErrorInterceptorHandler handler})>[];

  AuthInterceptor({
    required TokenManager tokenManager,
    Future<void> Function()? onTokenRefresh,
    void Function()? onLogout,
  }) : _tokenManager = tokenManager,
       _onTokenRefresh = onTokenRefresh,
       _onLogout = onLogout;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add access token if available
    final accessToken = _tokenManager.accessToken;
    if (accessToken != null && !_isPublicEndpoint(options.path)) {
      options.headers[HttpHeaders.authorization] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle 401 errors for authenticated requests
    if (err.response?.statusCode != 401 ||
        _isPublicEndpoint(err.requestOptions.path) ||
        _isRefreshEndpoint(err.requestOptions.path)) {
      return handler.next(err);
    }

    // If no refresh token available, logout
    if (_tokenManager.refreshToken == null) {
      _onLogout?.call();
      return handler.next(err);
    }

    // Handle token refresh with request queuing
    if (_isRefreshing) {
      // Queue this request to retry after refresh completes
      _pendingRequests.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    try {
      // Attempt to refresh the token
      await _onTokenRefresh?.call();

      // Retry the original request
      final response = await _retry(err.requestOptions);
      handler.resolve(response);

      // Process queued requests
      await _processQueuedRequests();
    } catch (e) {
      // Refresh failed, logout user
      _onLogout?.call();

      // Reject all pending requests
      _rejectQueuedRequests(err);
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  /// Retry a request with updated token
  Future<Response> _retry(RequestOptions options) async {
    final accessToken = _tokenManager.accessToken;
    if (accessToken != null) {
      options.headers[HttpHeaders.authorization] = 'Bearer $accessToken';
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: options.baseUrl,
        connectTimeout: options.connectTimeout,
        receiveTimeout: options.receiveTimeout,
      ),
    );

    return dio.fetch(options);
  }

  /// Process all queued requests after successful token refresh
  Future<void> _processQueuedRequests() async {
    final requests = List.of(_pendingRequests);
    _pendingRequests.clear();

    for (final request in requests) {
      try {
        final response = await _retry(request.options);
        request.handler.resolve(response);
      } catch (e) {
        request.handler.reject(
          DioException(requestOptions: request.options, error: e),
        );
      }
    }
  }

  /// Reject all queued requests
  void _rejectQueuedRequests(DioException error) {
    for (final request in _pendingRequests) {
      request.handler.reject(
        DioException(
          requestOptions: request.options,
          response: error.response,
          error: error.error,
          type: error.type,
        ),
      );
    }
    _pendingRequests.clear();
  }

  /// Check if the endpoint is public (doesn't require auth)
  bool _isPublicEndpoint(String path) {
    final publicEndpoints = [
      Endpoints.login,
      Endpoints.register,
      Endpoints.forgotPassword,
      Endpoints.resetPassword,
      Endpoints.verifyEmail,
      Endpoints.resendVerification,
    ];
    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }

  /// Check if this is a refresh token endpoint
  bool _isRefreshEndpoint(String path) {
    return path.contains(Endpoints.refreshToken);
  }
}
