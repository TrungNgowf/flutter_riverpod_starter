import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF1675F2);

  static const Color secondary = Color(0xFF3084F2);

  static const Color tertiary = Color(0xFFF2E96D);

  static const Color neutral = Color(0xFF566873);

  static const Color surface = Color(0xFFF1F2F0);

  /// Success states
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF059669);

  /// Warning states
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);

  /// Error states
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);

  /// Info states
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  /// Overlay colors for modals, dialogs
  static const Color overlayLight = Color(0x1A000000); // 10% black
  static const Color overlayMedium = Color(0x4D000000); // 30% black
  static const Color overlayDark = Color(0x80000000); // 50% black

  static final ColorScheme lightColorScheme = _lightColorScheme;
  static final ColorScheme darkColorScheme = _darkColorScheme;

  /// Light theme color scheme
  static final ColorScheme _lightColorScheme = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: primary,
    secondaryKey: secondary,
    tertiaryKey: tertiary,
    neutralKey: neutral,
    tones: FlexTones.vivid(Brightness.light),
    surfaceTint: primary,
  );

  /// Dark theme color scheme
  static final ColorScheme _darkColorScheme = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: primary,
    secondaryKey: secondary,
    tertiaryKey: tertiary,
    neutralKey: neutral,
    tones: FlexTones.vivid(Brightness.dark),
    surfaceTint: primary,
  );
}
