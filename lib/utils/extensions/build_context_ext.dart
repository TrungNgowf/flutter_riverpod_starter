import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/l10n/app_localizations.dart';

import 'extendable.dart';

extension BuildContextExt on Extendable<BuildContext> {
  AppLocalizations get l10n => AppLocalizations.of(base);
}
