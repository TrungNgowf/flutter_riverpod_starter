import 'package:dio/dio.dart';

/// Base class for all API exceptions
sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}

/// Network-related exceptions (no internet, timeout, etc.)
final class NetworkException extends ApiException {
  const NetworkException({
    super.message = 'Network error occurred',
    super.statusCode,
    super.data,
  });
}

/// Server returned an error response (4xx, 5xx)
final class ServerException extends ApiException {
  const ServerException({required super.message, super.statusCode, super.data});
}

/// Generic client-side HTTP error (4xx)
final class ClientException extends ApiException {
  const ClientException({required super.message, super.statusCode, super.data});
}

/// Authentication/Authorization exceptions
final class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.statusCode = 401,
    super.data,
  });
}

/// Forbidden access exception
final class ForbiddenException extends ApiException {
  const ForbiddenException({
    super.message = 'Access forbidden',
    super.statusCode = 403,
    super.data,
  });
}

/// Resource not found exception
final class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
    super.data,
  });
}

/// Request timeout exception
final class TimeoutException extends ApiException {
  const TimeoutException({
    super.message = 'Request timed out',
    super.statusCode,
    super.data,
  });
}

/// Request was cancelled
final class CancelledException extends ApiException {
  const CancelledException({
    super.message = 'Request was cancelled',
    super.statusCode,
    super.data,
  });
}

/// Bad request (400)
final class BadRequestException extends ApiException {
  const BadRequestException({
    super.message = 'Bad request',
    super.statusCode = 400,
    super.data,
  });
}

/// Request timeout returned by server (408)
final class RequestTimeoutException extends ApiException {
  const RequestTimeoutException({
    super.message = 'Request timeout',
    super.statusCode = 408,
    super.data,
  });
}

/// Conflict (409)
final class ConflictException extends ApiException {
  const ConflictException({
    super.message = 'Conflict',
    super.statusCode = 409,
    super.data,
  });
}

/// Gone (410)
final class GoneException extends ApiException {
  const GoneException({
    super.message = 'Resource gone',
    super.statusCode = 410,
    super.data,
  });
}

/// Method not allowed (405)
final class MethodNotAllowedException extends ApiException {
  const MethodNotAllowedException({
    super.message = 'Method not allowed',
    super.statusCode = 405,
    super.data,
  });
}

/// Unsupported media type (415)
final class UnsupportedMediaTypeException extends ApiException {
  const UnsupportedMediaTypeException({
    super.message = 'Unsupported media type',
    super.statusCode = 415,
    super.data,
  });
}

/// Validation error from server
final class ValidationException extends ApiException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    super.message = 'Validation failed',
    super.statusCode = 422,
    super.data,
    this.errors,
  });
}

/// Payment required (402)
final class PaymentRequiredException extends ApiException {
  const PaymentRequiredException({
    super.message = 'Payment required',
    super.statusCode = 402,
    super.data,
  });
}

/// Rate limit exceeded
final class RateLimitException extends ApiException {
  final Duration? retryAfter;

  const RateLimitException({
    super.message = 'Rate limit exceeded',
    super.statusCode = 429,
    super.data,
    this.retryAfter,
  });
}

/// Redirection error (3xx)
final class RedirectionException extends ApiException {
  const RedirectionException({
    super.message = 'Redirection error',
    super.statusCode,
    super.data,
  });
}

/// Internal server error (500)
final class InternalServerErrorException extends ApiException {
  const InternalServerErrorException({
    super.message = 'Internal server error',
    super.statusCode = 500,
    super.data,
  });
}

/// Not implemented (501)
final class NotImplementedServerException extends ApiException {
  const NotImplementedServerException({
    super.message = 'Not implemented',
    super.statusCode = 501,
    super.data,
  });
}

/// Bad gateway (502)
final class BadGatewayException extends ApiException {
  const BadGatewayException({
    super.message = 'Bad gateway',
    super.statusCode = 502,
    super.data,
  });
}

/// Service unavailable (503)
final class ServiceUnavailableException extends ApiException {
  const ServiceUnavailableException({
    super.message = 'Service unavailable',
    super.statusCode = 503,
    super.data,
  });
}

/// Gateway timeout (504)
final class GatewayTimeoutException extends ApiException {
  const GatewayTimeoutException({
    super.message = 'Gateway timeout',
    super.statusCode = 504,
    super.data,
  });
}

/// Invalid response (no status code)
final class InvalidResponseException extends ApiException {
  const InvalidResponseException({
    super.message = 'Invalid response from server',
    super.statusCode,
    super.data,
  });
}

/// Unknown/unexpected exception
final class UnknownApiException extends ApiException {
  const UnknownApiException({
    super.message = 'An unexpected error occurred',
    super.statusCode,
    super.data,
  });
}

/// Extension to convert DioException to ApiException
extension DioExceptionMapper on DioException {
  ApiException toApiException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: message ?? 'Request timed out');

      case DioExceptionType.connectionError:
        return NetworkException(message: message ?? 'Connection error');

      case DioExceptionType.cancel:
        return CancelledException(message: message ?? 'Request cancelled');

      case DioExceptionType.badResponse:
        return _mapResponseError(response);

      case DioExceptionType.badCertificate:
        return const NetworkException(message: 'Invalid SSL certificate');

      case DioExceptionType.unknown:
        if (message?.contains('SocketException') == true) {
          return const NetworkException(message: 'No internet connection');
        }
        return UnknownApiException(message: message ?? 'Unknown error');
    }
  }

  ApiException _mapResponseError(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    // Try to extract error message from response
    String message = 'Server error';
    if (data is Map<String, dynamic>) {
      message =
          data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String? ??
          'Server error';
    }

    if (statusCode == null) {
      return InvalidResponseException(message: message, data: data);
    }

    if (statusCode >= 500) {
      return switch (statusCode) {
        500 => InternalServerErrorException(message: message, data: data),
        501 => NotImplementedServerException(message: message, data: data),
        502 => BadGatewayException(message: message, data: data),
        503 => ServiceUnavailableException(message: message, data: data),
        504 => GatewayTimeoutException(message: message, data: data),
        _ => ServerException(
          message: message,
          statusCode: statusCode,
          data: data,
        ),
      };
    }

    if (statusCode >= 300 && statusCode < 400) {
      return RedirectionException(
        message: message,
        statusCode: statusCode,
        data: data,
      );
    }

    return switch (statusCode) {
      400 => BadRequestException(message: message, data: data),
      401 => UnauthorizedException(message: message, data: data),
      402 => PaymentRequiredException(message: message, data: data),
      403 => ForbiddenException(message: message, data: data),
      404 => NotFoundException(message: message, data: data),
      405 => MethodNotAllowedException(message: message, data: data),
      408 => RequestTimeoutException(message: message, data: data),
      409 => ConflictException(message: message, data: data),
      410 => GoneException(message: message, data: data),
      415 => UnsupportedMediaTypeException(message: message, data: data),
      422 => ValidationException(
        message: message,
        data: data,
        errors: _extractValidationErrors(data),
      ),
      429 => RateLimitException(
        message: message,
        data: data,
        retryAfter: _extractRetryAfter(response),
      ),
      _ => ClientException(
        message: message,
        statusCode: statusCode,
        data: data,
      ),
    };
  }

  Map<String, List<String>>? _extractValidationErrors(dynamic data) {
    if (data is! Map<String, dynamic>) return null;

    final errors = data['errors'];
    if (errors is! Map<String, dynamic>) return null;

    return errors.map((key, value) {
      if (value is List) {
        return MapEntry(key, value.cast<String>());
      }
      return MapEntry(key, [value.toString()]);
    });
  }

  Duration? _extractRetryAfter(Response? response) {
    final retryAfter = response?.headers.value('retry-after');
    if (retryAfter == null) return null;

    final seconds = int.tryParse(retryAfter);
    if (seconds != null) return Duration(seconds: seconds);

    return null;
  }
}
