import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:flutter_riverpod_starter/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

/// Provider for the main API client (requires authentication)
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final logger = ref.ext.logger;
  final tokenManager = ref.watch(tokenManagerProvider);
  final config = ref.watch(appConfigProvider);

  return ApiClient(
    baseUrl: Env().baseUrl,
    config: config,
    logger: logger,
    tokenManager: tokenManager,
    onLogout: () {
      // TODO: Handle logout (clear auth state, navigate to login)
      // ref.read(authControllerProvider.notifier).logout();
    },
    onTokenRefresh: () async {
      // TODO: Implement token refresh logic
      // await ref.read(authControllerProvider.notifier).refreshToken();
    },
  );
}

/// Provider for public API client (no authentication required)
@Riverpod(keepAlive: true)
ApiClient publicApiClient(Ref ref) {
  final logger = ref.watch(appLoggerProvider);
  final config = ref.watch(appConfigProvider);

  return ApiClient.public(
    baseUrl: Env().baseUrl,
    config: config,
    logger: logger,
  );
}

/// Main API client wrapper around Dio
/// Provides a clean interface for making HTTP requests
class ApiClient {
  final Dio _dio;
  final AppConfig _config;
  final TokenManager? _tokenManager;

  ApiClient._({
    required Dio dio,
    required AppConfig config,
    TokenManager? tokenManager,
  })
    : _dio = dio,
      _config = config,
      _tokenManager = tokenManager;

  /// Create an authenticated API client
  factory ApiClient({
    required String baseUrl,
    required AppConfig config,
    required AppLogger logger,
    required TokenManager tokenManager,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    void Function()? onLogout,
    Future<void> Function()? onTokenRefresh,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          HttpHeaders.contentType: ContentTypes.json,
          HttpHeaders.accept: ContentTypes.json,
        },
      ),
    );

    // Add interceptors in order
    // 1. Timing (must be first to track request duration)
    dio.interceptors.add(TimingInterceptor());

    // 2. Auth interceptor (adds token, handles refresh)
    dio.interceptors.add(
      AuthInterceptor(
        tokenManager: tokenManager,
        onLogout: onLogout,
        onTokenRefresh: onTokenRefresh,
      ),
    );

    // 3. Retry interceptor (handles retries)
    dio.interceptors.add(
      RetryInterceptor(dio: dio, config: RetryConfig.defaultConfig),
    );

    // 4. Logging interceptor (logs requests/responses)
    if (config.enableLogging) {
      dio.interceptors.add(
        LoggingInterceptor(
          logger: logger,
          logRequestBody: true,
          logResponseBody: true,
          logHeaders: true,
        ),
      );
    }

    // 5. Error interceptor (transforms errors)
    dio.interceptors.add(ErrorInterceptor());

    return ApiClient._(dio: dio, config: config, tokenManager: tokenManager);
  }

  /// Create a public API client (no authentication)
  factory ApiClient.public({
    required String baseUrl,
    required AppConfig config,
    required AppLogger logger,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          HttpHeaders.contentType: ContentTypes.json,
          HttpHeaders.accept: ContentTypes.json,
        },
      ),
    );

    // Add interceptors (without auth)
    dio.interceptors.add(TimingInterceptor());

    dio.interceptors.add(
      RetryInterceptor(dio: dio, config: RetryConfig.defaultConfig),
    );

    if (config.enableLogging) {
      dio.interceptors.add(
        LoggingInterceptor(
          logger: logger,
          logRequestBody: true,
          logResponseBody: true,
          logHeaders: true,
        ),
      );
    }

    dio.interceptors.add(ErrorInterceptor());

    return ApiClient._(dio: dio, config: config);
  }

  /// Access the underlying Dio instance (for advanced usage)
  Dio get dio => _dio;

  /// Access the token manager
  TokenManager? get tokenManager => _tokenManager;

  /// Access app config for future usage
  AppConfig get config => _config;

  // ============== HTTP Methods ==============

  /// GET request
  AsyncApiResult<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic data) parser,
  }) async {
    return _request(
      () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      parser: parser,
    );
  }

  /// POST request
  AsyncApiResult<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic data) parser,
  }) async {
    return _request(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      parser: parser,
    );
  }

  /// PUT request
  AsyncApiResult<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic data) parser,
  }) async {
    return _request(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      parser: parser,
    );
  }

  /// PATCH request
  AsyncApiResult<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic data) parser,
  }) async {
    return _request(
      () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      parser: parser,
    );
  }

  /// DELETE request
  AsyncApiResult<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic data) parser,
  }) async {
    return _request(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      parser: parser,
    );
  }

  /// Upload file with progress tracking
  AsyncApiResult<T> upload<T>(
    String path, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int sent, int total)? onSendProgress,
    required T Function(dynamic data) parser,
  }) async {
    return _request(
      () => _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      ),
      parser: parser,
    );
  }

  /// Download file with progress tracking
  AsyncApiResult<Response> download(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    return _request(
      () => _dio.download(
        path,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      parser: (data) => data as Response,
    );
  }

  // ============== Helper Methods ==============

  /// Internal request wrapper with error handling
  Future<ApiResult<T>> _request<T>(
    Future<Response> Function() request, {
    required T Function(dynamic data) parser,
  }) async {
    try {
      final response = await request();
      final result = parser(response.data);
      return ApiResultHelper.success(result);
    } on DioException catch (e) {
      return ApiResultHelper.failure(e.toApiException());
    } catch (e) {
      return ApiResultHelper.failure(
        UnknownApiException(message: e.toString()),
      );
    }
  }

  /// Set custom headers for all requests
  void setHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  /// Remove a header
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  /// Set language header
  void setLanguage(String languageCode) {
    _dio.options.headers[HttpHeaders.acceptLanguage] = languageCode;
  }
}
