import 'package:flutter_riverpod_starter/features/songs/state/songs_state.dart';
import 'package:flutter_riverpod_starter/models/song/song.dart';
import 'package:flutter_riverpod_starter/services/songs_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'songs_provider.g.dart';

@riverpod
class SongsNotifier extends _$SongsNotifier {
  @override
  SongsState build() {
    Future(() => fetchSongs());
    return const SongsState.initial();
  }

  SongsService get _service => ref.read(songsServiceProvider);

  /// Fetch songs from API
  Future<void> fetchSongs({String? search}) async {
    state = SongsState.loading(searchQuery: search);

    final result = await _service.getSongs(search: search);

    state = result.fold(
      (error) => SongsState.error(error: error, searchQuery: search),
      (songs) => SongsState.success(songs: songs, searchQuery: search),
    );
  }

  /// Refresh songs (pull-to-refresh)
  Future<void> refresh() async {
    final currentSongs = state.songs;
    final currentQuery = state.searchQuery;

    state = SongsState.refreshing(
      songs: currentSongs,
      searchQuery: currentQuery,
    );

    final result = await _service.getSongs(search: currentQuery);

    state = result.fold(
      (error) => SongsState.error(error: error, searchQuery: currentQuery),
      (songs) => SongsState.success(songs: songs, searchQuery: currentQuery),
    );
  }

  /// Search songs
  Future<void> search(String query) async {
    await fetchSongs(search: query.isEmpty ? null : query);
  }
}

/// Provider for fetching a single song by ID
@riverpod
Future<Song> songDetail(Ref ref, String id) async {
  final service = ref.watch(songsServiceProvider);
  final result = await service.getSongById(id);

  return result.fold((error) => throw error, (song) => song);
}
