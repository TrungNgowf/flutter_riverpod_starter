// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for TokenManager

@ProviderFor(tokenManager)
const tokenManagerProvider = TokenManagerProvider._();

/// Provider for TokenManager

final class TokenManagerProvider
    extends $FunctionalProvider<TokenManager, TokenManager, TokenManager>
    with $Provider<TokenManager> {
  /// Provider for TokenManager
  const TokenManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenManagerHash();

  @$internal
  @override
  $ProviderElement<TokenManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenManager create(Ref ref) {
    return tokenManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenManager>(value),
    );
  }
}

String _$tokenManagerHash() => r'94bb9e39530e1d18331ea750bd4b6c5d4f16f1e9';
