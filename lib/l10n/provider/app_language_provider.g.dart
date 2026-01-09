// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppLanguageController)
const appLanguageControllerProvider = AppLanguageControllerProvider._();

final class AppLanguageControllerProvider
    extends $NotifierProvider<AppLanguageController, AppLanguage> {
  const AppLanguageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLanguageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLanguageControllerHash();

  @$internal
  @override
  AppLanguageController create() => AppLanguageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLanguage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLanguage>(value),
    );
  }
}

String _$appLanguageControllerHash() =>
    r'ca140c2eb55ab4475e1421e078ace151eaacdae2';

abstract class _$AppLanguageController extends $Notifier<AppLanguage> {
  AppLanguage build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppLanguage, AppLanguage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLanguage, AppLanguage>,
              AppLanguage,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
