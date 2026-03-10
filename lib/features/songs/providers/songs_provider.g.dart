// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SongsNotifier)
const songsProvider = SongsNotifierProvider._();

final class SongsNotifierProvider
    extends $NotifierProvider<SongsNotifier, SongsState> {
  const SongsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songsNotifierHash();

  @$internal
  @override
  SongsNotifier create() => SongsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongsState>(value),
    );
  }
}

String _$songsNotifierHash() => r'582dc6d41f9698569cf4ed72a10f49cde32c151a';

abstract class _$SongsNotifier extends $Notifier<SongsState> {
  SongsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SongsState, SongsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SongsState, SongsState>,
              SongsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for fetching a single song by ID

@ProviderFor(songDetail)
const songDetailProvider = SongDetailFamily._();

/// Provider for fetching a single song by ID

final class SongDetailProvider
    extends $FunctionalProvider<AsyncValue<Song>, Song, FutureOr<Song>>
    with $FutureModifier<Song>, $FutureProvider<Song> {
  /// Provider for fetching a single song by ID
  const SongDetailProvider._({
    required SongDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'songDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$songDetailHash();

  @override
  String toString() {
    return r'songDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Song> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Song> create(Ref ref) {
    final argument = this.argument as String;
    return songDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SongDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$songDetailHash() => r'dda4ce1437e2fa2557dbda10fdcb467cbc579450';

/// Provider for fetching a single song by ID

final class SongDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Song>, String> {
  const SongDetailFamily._()
    : super(
        retry: null,
        name: r'songDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for fetching a single song by ID

  SongDetailProvider call(String id) =>
      SongDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'songDetailProvider';
}
