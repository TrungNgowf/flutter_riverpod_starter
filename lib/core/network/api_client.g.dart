// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the main API client (requires authentication)

@ProviderFor(apiClient)
const apiClientProvider = ApiClientProvider._();

/// Provider for the main API client (requires authentication)

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  /// Provider for the main API client (requires authentication)
  const ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'16c14e7c89f61d556b93bfbce5cbba39e56172d1';

/// Provider for public API client (no authentication required)

@ProviderFor(publicApiClient)
const publicApiClientProvider = PublicApiClientProvider._();

/// Provider for public API client (no authentication required)

final class PublicApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  /// Provider for public API client (no authentication required)
  const PublicApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicApiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return publicApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$publicApiClientHash() => r'cbed589778b2cb3ca42d2dad752add9dee73aa45';
