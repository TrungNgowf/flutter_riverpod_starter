import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod_starter/core/network/api_helpers/api_exception.dart';

/// Type alias for API results using Either from fpdart
/// Left = Error (ApiException), Right = Success (T)
typedef ApiResult<T> = Either<ApiException, T>;

/// Type alias for async API results
typedef AsyncApiResult<T> = Future<ApiResult<T>>;

/// Extension methods for ApiResult
extension ApiResultExtension<T> on ApiResult<T> {
  /// Returns true if the result is successful
  bool get isSuccess => isRight();

  /// Returns true if the result is a failure
  bool get isFailure => isLeft();

  /// Get the success value or null
  T? get successOrNull => getRight().toNullable();

  /// Get the error or null
  ApiException? get errorOrNull => getLeft().toNullable();

  /// Get the success value or throw
  T get successOrThrow => getOrElse((error) => throw error);

  /// Handle both success and failure cases
  R when<R>({
    required R Function(T data) success,
    required R Function(ApiException error) failure,
  }) {
    return fold(failure, success);
  }

  /// Transform the success value
  ApiResult<R> mapSuccess<R>(R Function(T data) transform) {
    return map(transform);
  }

  /// Transform the error value
  ApiResult<T> mapError(ApiException Function(ApiException error) transform) {
    return mapLeft(transform);
  }

  /// Execute side effect on success
  ApiResult<T> onSuccess(void Function(T data) action) {
    if (isRight()) {
      action(successOrThrow);
    }
    return this;
  }

  /// Execute side effect on failure
  ApiResult<T> onFailure(void Function(ApiException error) action) {
    if (isLeft()) {
      action(errorOrNull!);
    }
    return this;
  }
}

extension AsyncApiResultExtension<T> on AsyncApiResult<T> {
  /// Transform the success value asynchronously
  AsyncApiResult<R> mapSuccess<R>(R Function(T data) transform) {
    return then((result) => result.map(transform));
  }

  /// Handle both success and failure cases asynchronously
  Future<R> when<R>({
    required R Function(T data) success,
    required R Function(ApiException error) failure,
  }) {
    return then((result) => result.fold(failure, success));
  }
}

/// Helper functions for creating ApiResult
class ApiResultHelper {
  /// Create a success result
  static ApiResult<T> success<T>(T data) => Either.right(data);

  /// Create a failure result
  static ApiResult<T> failure<T>(ApiException error) => Either.left(error);

  /// Try to execute a function and wrap the result
  static Future<ApiResult<T>> guard<T>(Future<T> Function() fn) async {
    try {
      final result = await fn();
      return Either.right(result);
    } on ApiException catch (e) {
      return Either.left(e);
    } catch (e) {
      return Either.left(UnknownApiException(message: e.toString()));
    }
  }
}
