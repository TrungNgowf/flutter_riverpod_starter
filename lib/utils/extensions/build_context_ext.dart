import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:flutter_riverpod_starter/l10n/app_localizations.dart';
import 'package:flutter_riverpod_starter/router/app_router.dart';

import 'extendable.dart';

extension BuildContextExt on Extendable<BuildContext> {
  /// app localizations
  AppLocalizations get l10n => AppLocalizations.of(base);

  /// current color scheme
  ColorScheme get colors => Theme.of(base).colorScheme;

  /// current text theme
  TextTheme get textTheme => Theme.of(base).textTheme;

  double get screenWidth => MediaQuery.sizeOf(base).width;

  double get screenHeight => MediaQuery.sizeOf(base).height;

  bool get isXs => screenWidth < AppSizes.breakpointSm;

  bool get isSm =>
      screenWidth >= AppSizes.breakpointSm &&
      screenWidth < AppSizes.breakpointMd;

  bool get isMd =>
      screenWidth >= AppSizes.breakpointMd &&
      screenWidth < AppSizes.breakpointLg;

  bool get isLg =>
      screenWidth >= AppSizes.breakpointLg &&
      screenWidth < AppSizes.breakpointXl;

  bool get isXl => screenWidth >= AppSizes.breakpointXl;

  bool get isMobile => screenWidth < AppSizes.breakpointMd;

  bool get isTablet =>
      screenWidth >= AppSizes.breakpointMd &&
      screenWidth < AppSizes.breakpointLg;

  bool get isDesktop => screenWidth >= AppSizes.breakpointLg;
}
