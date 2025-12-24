import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'extendable.dart';

// Extension for Ref (used in providers)
extension RefExt on Extendable<Ref> {
  AppConfig get appConfig => base.read(appConfigProvider);

  AppLogger get logger => base.read(appLoggerProvider);
}

// Extension for WidgetRef (used in widgets)
extension WidgetRefExt on Extendable<WidgetRef> {
  AppConfig get appConfig => base.read(appConfigProvider);

  AppLogger get logger => base.read(appLoggerProvider);
}
