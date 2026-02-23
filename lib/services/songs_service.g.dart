// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for SongsService

@ProviderFor(songsService)
const songsServiceProvider = SongsServiceProvider._();

/// Provider for SongsService

final class SongsServiceProvider
    extends $FunctionalProvider<SongsService, SongsService, SongsService>
    with $Provider<SongsService> {
  /// Provider for SongsService
  const SongsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songsServiceHash();

  @$internal
  @override
  $ProviderElement<SongsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SongsService create(Ref ref) {
    return songsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongsService>(value),
    );
  }
}

String _$songsServiceHash() => r'808e32cd6b746d9995e2e6e677f56f103465143b';
