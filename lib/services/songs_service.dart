import 'package:flutter_riverpod_starter/core/network/api_client.dart';
import 'package:flutter_riverpod_starter/core/network/api_helpers/api_response.dart';
import 'package:flutter_riverpod_starter/core/network/api_helpers/api_result.dart';
import 'package:flutter_riverpod_starter/core/network/base_repository.dart';
import 'package:flutter_riverpod_starter/core/network/endpoints.dart';
import 'package:flutter_riverpod_starter/models/song/song.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'songs_service.g.dart';

/// Provider for SongsService
@Riverpod(keepAlive: true)
SongsService songsService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SongsService(apiClient);
}

/// Service for songs-related API calls
class SongsService extends BaseRepository {
  final ApiClient _client;

  const SongsService(this._client) : super(_client);

  /// Fetch list of songs (non-paginated)
  AsyncApiResult<List<Song>> getSongs({
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = <String, dynamic>{};

    if (search != null && search.isNotEmpty) {
      queryParams[QueryParams.search] = search;
    }
    if (sortBy != null) {
      queryParams[QueryParams.sortBy] = sortBy;
    }
    if (sortOrder != null) {
      queryParams[QueryParams.sortOrder] = sortOrder;
    }

    return _client.get(
      Endpoints.songs,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      parser: (data) => parseList(data, Song.fromJson),
    );
  }

  /// Fetch paginated songs
  AsyncApiResult<PaginatedResponse<Song>> getSongsPaginated({
    int page = 1,
    int perPage = 20,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = <String, dynamic>{
      QueryParams.page: page,
      QueryParams.perPage: perPage,
    };

    if (search != null && search.isNotEmpty) {
      queryParams[QueryParams.search] = search;
    }
    if (sortBy != null) {
      queryParams[QueryParams.sortBy] = sortBy;
    }
    if (sortOrder != null) {
      queryParams[QueryParams.sortOrder] = sortOrder;
    }

    return _client.get(
      Endpoints.songs,
      queryParameters: queryParams,
      parser: (data) => parsePaginatedResponse(data, Song.fromJson),
    );
  }

  /// Fetch a single song by ID
  AsyncApiResult<Song> getSongById(String id) async {
    return _client.get(
      '${Endpoints.songs}/$id',
      parser: (data) => parseDataResponse(data, Song.fromJson),
    );
  }
}
