import 'package:flutter/material.dart';

abstract final class AppSizes {
  // ═══════════════════════════════════════════════════════════════════════════
  // SPACING
  // ═══════════════════════════════════════════════════════════════════════════

  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing6 = 6;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;
  static const double spacing56 = 56;
  static const double spacing64 = 64;

  // Semantic Spacing
  static const double space3xs = spacing2;
  static const double space2xs = spacing4;
  static const double spaceXs = spacing6;
  static const double spaceSm = spacing8;
  static const double spaceMd = spacing12;
  static const double spaceLg = spacing16;
  static const double spaceXl = spacing24;
  static const double space2xl = spacing32;
  static const double space3xl = spacing48;

  // ═══════════════════════════════════════════════════════════════════════════
  // BORDER RADIUS
  // ═══════════════════════════════════════════════════════════════════════════

  static const double radius4 = 4;
  static const double radius8 = 8;
  static const double radius12 = 12;
  static const double radius16 = 16;
  static const double radius20 = 20;
  static const double radius24 = 24;
  static const double radius28 = 28;
  static const double radiusFull = 9999;

  // Semantic Radius
  static const double radiusXs = radius4;
  static const double radiusSm = radius8;
  static const double radiusMd = radius12;
  static const double radiusLg = radius16;
  static const double radiusXl = radius24;
  static const double radius2xl = radius28;

  static BorderRadius get borderRadiusXs => BorderRadius.circular(radiusXs);

  static BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);

  static BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);

  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);

  static BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);

  static BorderRadius get borderRadiusFull => BorderRadius.circular(radiusFull);

  // ═══════════════════════════════════════════════════════════════════════════
  // ICON SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 28;
  static const double iconXl = 32;
  static const double icon2xl = 40;
  static const double icon3xl = 48;

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPONENT SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  static const double buttonHeight = 48;
  static const double buttonHeightSm = 36;
  static const double buttonHeightLg = 56;

  static const double inputHeight = 56;
  static const double inputHeightSm = 44;

  static const double appBarHeight = 56;
  static const double bottomNavHeight = 72;
  static const double fabSize = 56;
  static const double fabSizeSm = 40;

  // ═══════════════════════════════════════════════════════════════════════════
  // BREAKPOINTS (for responsive design)
  // ═══════════════════════════════════════════════════════════════════════════

  static const double breakpointXs = 0;
  static const double breakpointSm = 600;
  static const double breakpointMd = 905;
  static const double breakpointLg = 1240;
  static const double breakpointXl = 1440;

  // ═══════════════════════════════════════════════════════════════════════════
  // ELEVATION
  // ═══════════════════════════════════════════════════════════════════════════

  static const double elevation0 = 0;
  static const double elevation1 = 1;
  static const double elevation2 = 2;
  static const double elevation3 = 3;
  static const double elevation4 = 4;
  static const double elevation6 = 6;
  static const double elevation8 = 8;

  // ═══════════════════════════════════════════════════════════════════════════
  // ANIMATION DURATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // ═══════════════════════════════════════════════════════════════════════════
  // PADDING PRESETS
  // ═══════════════════════════════════════════════════════════════════════════

  static const EdgeInsets paddingAll4 = EdgeInsets.all(spacing4);
  static const EdgeInsets paddingAll8 = EdgeInsets.all(spacing8);
  static const EdgeInsets paddingAll12 = EdgeInsets.all(spacing12);
  static const EdgeInsets paddingAll16 = EdgeInsets.all(spacing16);
  static const EdgeInsets paddingAll24 = EdgeInsets.all(spacing24);

  // Semantic Padding
  static const EdgeInsets padding3xs = EdgeInsets.all(space3xs);
  static const EdgeInsets padding2xs = EdgeInsets.all(space2xs);
  static const EdgeInsets paddingXs = EdgeInsets.all(spaceXs);
  static const EdgeInsets paddingSm = EdgeInsets.all(spaceSm);
  static const EdgeInsets paddingMd = EdgeInsets.all(spaceMd);
  static const EdgeInsets paddingLg = EdgeInsets.all(spaceLg);
  static const EdgeInsets paddingXl = EdgeInsets.all(spaceXl);

  static const EdgeInsets paddingH8 = EdgeInsets.symmetric(
    horizontal: spacing8,
  );
  static const EdgeInsets paddingH12 = EdgeInsets.symmetric(
    horizontal: spacing12,
  );
  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(
    horizontal: spacing16,
  );
  static const EdgeInsets paddingH24 = EdgeInsets.symmetric(
    horizontal: spacing24,
  );

  static const EdgeInsets paddingV8 = EdgeInsets.symmetric(vertical: spacing8);
  static const EdgeInsets paddingV12 = EdgeInsets.symmetric(
    vertical: spacing12,
  );
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(
    vertical: spacing16,
  );
  static const EdgeInsets paddingV24 = EdgeInsets.symmetric(
    vertical: spacing24,
  );

  static const EdgeInsets paddingPage = EdgeInsets.symmetric(
    horizontal: spaceLg,
    vertical: spaceXl,
  );
}
