import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) {
  return switch (Env.flavor) {
    .develop => AppConfig.develop(),
    .staging => AppConfig.staging(),
    .production => AppConfig.production(),
  };
}

class AppConfig {
  final bool enableAnalytics;
  final bool enableCrashlytics;
  final FeatureFlags featureFlags;

  const AppConfig._({
    required this.enableAnalytics,
    required this.enableCrashlytics,
    required this.featureFlags,
  });

  factory AppConfig.develop() => ._(
    enableAnalytics: false,
    enableCrashlytics: false,
    featureFlags: .develop(),
  );

  factory AppConfig.staging() => ._(
    enableAnalytics: false,
    enableCrashlytics: false,
    featureFlags: .staging(),
  );

  factory AppConfig.production() => ._(
    enableAnalytics: true,
    enableCrashlytics: true,
    featureFlags: .production(),
  );
}

/// Feature flags for the app.
class FeatureFlags {
  final bool enableFeatureA;
  final bool enableFeatureB;

  const FeatureFlags._({
    required this.enableFeatureA,
    required this.enableFeatureB,
  });

  factory FeatureFlags.develop() =>
      FeatureFlags._(enableFeatureA: true, enableFeatureB: true);

  factory FeatureFlags.staging() =>
      FeatureFlags._(enableFeatureA: true, enableFeatureB: true);

  factory FeatureFlags.production() =>
      FeatureFlags._(enableFeatureA: true, enableFeatureB: true);
}
