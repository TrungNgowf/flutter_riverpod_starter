/// Generic API response wrapper for paginated data
class PaginatedResponse<T> {
  final List<T> data;
  final PaginationMeta meta;

  const PaginatedResponse({
    required this.data,
    required this.meta,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final dataList = (json['data'] as List<dynamic>?) ?? [];
    return PaginatedResponse(
      data: dataList
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
      meta: PaginationMeta.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  bool get hasMore => meta.currentPage < meta.lastPage;
  bool get isEmpty => data.isEmpty;
  int get total => meta.total;
}

/// Pagination metadata
class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total,
      };
}

/// Generic API response for single data
class ApiDataResponse<T> {
  final T data;
  final String? message;

  const ApiDataResponse({
    required this.data,
    this.message,
  });

  factory ApiDataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return ApiDataResponse(
      data: fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );
  }
}

/// Generic API response for list data (non-paginated)
class ApiListResponse<T> {
  final List<T> data;
  final String? message;

  const ApiListResponse({
    required this.data,
    this.message,
  });

  factory ApiListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final dataList = (json['data'] as List<dynamic>?) ?? [];
    return ApiListResponse(
      data: dataList
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );
  }
}

/// Simple message response
class MessageResponse {
  final String message;
  final bool success;

  const MessageResponse({
    required this.message,
    this.success = true,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      message: json['message'] as String? ?? '',
      success: json['success'] as bool? ?? true,
    );
  }
}
