import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
