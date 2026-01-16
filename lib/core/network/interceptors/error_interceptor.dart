import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter/core/network/api_helpers/api_exception.dart';

/// Interceptor that transforms DioException to ApiException
/// This provides a consistent error handling interface across the app
class ErrorInterceptor extends Interceptor {
  final void Function(ApiException error)? _onError;

  ErrorInterceptor({
    void Function(ApiException error)? onError,
  }) : _onError = onError;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiException = err.toApiException();
    
    // Notify listeners about the error
    _onError?.call(apiException);
    
    // Continue with the original error
    // The calling code should use toApiException() to get the typed exception
    handler.next(err);
  }
}

/// Extension to add ApiException to DioException
extension DioExceptionApiException on DioException {
  /// Get the ApiException from DioException extra data
  /// This is used after ErrorInterceptor processes the error
  ApiException get apiException {
    return toApiException();
  }
}
