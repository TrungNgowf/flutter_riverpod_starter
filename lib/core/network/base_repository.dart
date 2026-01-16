import 'package:flutter_riverpod_starter/core/network/api_client.dart';
import 'package:flutter_riverpod_starter/core/network/api_helpers/api_exception.dart';

import 'api_helpers/api_response.dart';
import 'api_helpers/api_result.dart';

/// Base repository class that provides common functionality
/// Extend this class to create feature-specific repositories
abstract class BaseRepository {
  final ApiClient _apiClient;

  const BaseRepository(this._apiClient);

  // ============== Helper Methods ==============

  /// Parse a single object from response data
  T parseObject<T>(dynamic data, T Function(Map<String, dynamic>) fromJson) {
    if (data is Map<String, dynamic>) {
      return fromJson(data);
    }
    throw const UnknownApiException(
      message: 'Invalid response format: expected object',
    );
  }

  /// Parse a list of objects from response data
  List<T> parseList<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data is List) {
      return data
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw const UnknownApiException(
      message: 'Invalid response format: expected list',
    );
  }

  /// Parse wrapped data response (e.g., {"data": {...}})
  T parseDataResponse<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data is Map<String, dynamic>) {
      final innerData = data['data'];
      if (innerData is Map<String, dynamic>) {
        return fromJson(innerData);
      }
    }
    throw const UnknownApiException(
      message: 'Invalid response format: expected wrapped data',
    );
  }

  /// Parse wrapped list response (e.g., {"data": [...]})
  List<T> parseDataListResponse<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data is Map<String, dynamic>) {
      final innerData = data['data'];
      if (innerData is List) {
        return innerData
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      }
    }
    throw const UnknownApiException(
      message: 'Invalid response format: expected wrapped list',
    );
  }

  /// Parse paginated response
  PaginatedResponse<T> parsePaginatedResponse<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data is Map<String, dynamic>) {
      return PaginatedResponse.fromJson(data, fromJson);
    }
    throw const UnknownApiException(
      message: 'Invalid response format: expected paginated data',
    );
  }

  /// Parse message response
  MessageResponse parseMessageResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      return MessageResponse.fromJson(data);
    }
    return MessageResponse(message: data?.toString() ?? 'Success');
  }
}

/// Mixin for repositories that need pagination support
mixin PaginationMixin<T> on BaseRepository {
  /// Fetch paginated data
  AsyncApiResult<PaginatedResponse<T>> fetchPaginated(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    int page = 1,
    int perPage = 20,
    Map<String, dynamic>? additionalParams,
  }) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
      ...?additionalParams,
    };

    return _apiClient.get(
      endpoint,
      queryParameters: queryParams,
      parser: (data) => parsePaginatedResponse(data, fromJson),
    );
  }

  /// Fetch all pages (use with caution)
  AsyncApiResult<List<T>> fetchAll(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    int perPage = 100,
    Map<String, dynamic>? additionalParams,
  }) async {
    final allItems = <T>[];
    var currentPage = 1;
    var hasMore = true;

    while (hasMore) {
      final result = await fetchPaginated(
        endpoint,
        fromJson,
        page: currentPage,
        perPage: perPage,
        additionalParams: additionalParams,
      );

      final failureOrSuccess = result.fold((error) => error, (response) {
        allItems.addAll(response.data);
        hasMore = response.hasMore;
        currentPage++;
        return null;
      });

      if (failureOrSuccess != null) {
        return ApiResultHelper.failure(failureOrSuccess);
      }
    }

    return ApiResultHelper.success(allItems);
  }
}
