import 'package:flutter_riverpod_starter/core/network/api_helpers/api_exception.dart';
import 'package:flutter_riverpod_starter/models/song/song.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'songs_state.freezed.dart';

/// State class for songs list using Freezed 3.x with sealed class
@freezed
sealed class SongsState with _$SongsState {
  const SongsState._();

  /// Initial state
  const factory SongsState.initial() = SongsInitial;

  /// Loading state
  const factory SongsState.loading({String? searchQuery}) = SongsLoading;

  /// Refreshing state (pull-to-refresh)
  const factory SongsState.refreshing({
    required List<Song> songs,
    String? searchQuery,
  }) = SongsRefreshing;

  /// Success state with data
  const factory SongsState.success({
    required List<Song> songs,
    String? searchQuery,
  }) = SongsSuccess;

  /// Error state
  const factory SongsState.error({
    required ApiException error,
    String? searchQuery,
  }) = SongsError;

  /// Helper getters
  bool get isLoading => this is SongsLoading;
  bool get isRefreshing => this is SongsRefreshing;
  bool get hasError => this is SongsError;

  List<Song> get songs => switch (this) {
    SongsSuccess(:final songs) => songs,
    SongsRefreshing(:final songs) => songs,
    _ => [],
  };

  String? get searchQuery => switch (this) {
    SongsLoading(:final searchQuery) => searchQuery,
    SongsRefreshing(:final searchQuery) => searchQuery,
    SongsSuccess(:final searchQuery) => searchQuery,
    SongsError(:final searchQuery) => searchQuery,
    _ => null,
  };
}
