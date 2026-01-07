import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static final ThemeData light = _buildTheme(
    colorScheme: AppColors.lightColorScheme,
    brightness: Brightness.light,
  );

  static final ThemeData dark = _buildTheme(
    colorScheme: AppColors.darkColorScheme,
    brightness: Brightness.dark,
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    final isLight = brightness == Brightness.light;
    final textTheme = AppTypography.textTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: AppTypography.fontFamily,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // App Bar
      appBarTheme: _appBarTheme(colorScheme, isLight),

      // Buttons
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      filledButtonTheme: _filledButtonTheme(colorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme),
      textButtonTheme: _textButtonTheme(colorScheme),
      iconButtonTheme: _iconButtonTheme(colorScheme),
      floatingActionButtonTheme: _fabTheme(colorScheme),
      segmentedButtonTheme: _segmentedButtonTheme(colorScheme),

      // Cards & Containers
      cardTheme: _cardTheme(colorScheme),
      drawerTheme: _drawerTheme(colorScheme),
      bottomSheetTheme: _bottomSheetTheme(colorScheme),
      dialogTheme: _dialogTheme(colorScheme),

      // Navigation
      navigationBarTheme: _navigationBarTheme(colorScheme),
      navigationRailTheme: _navigationRailTheme(colorScheme),
      tabBarTheme: _tabBarTheme(colorScheme),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme),

      // Inputs
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      searchBarTheme: _searchBarTheme(colorScheme),
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),

      // Lists & Tiles
      listTileTheme: _listTileTheme(colorScheme),
      expansionTileTheme: _expansionTileTheme(colorScheme),

      // Menus
      popupMenuTheme: _popupMenuTheme(colorScheme),
      menuTheme: _menuTheme(colorScheme),
      menuBarTheme: _menuBarTheme(colorScheme),
      menuButtonTheme: _menuButtonTheme(colorScheme),

      // Pickers
      datePickerTheme: _datePickerTheme(colorScheme),
      timePickerTheme: _timePickerTheme(colorScheme),

      // Selection Controls
      switchTheme: _switchTheme(colorScheme),
      checkboxTheme: _checkboxTheme(colorScheme),
      radioTheme: _radioTheme(colorScheme),
      sliderTheme: _sliderTheme(colorScheme),
      chipTheme: _chipTheme(colorScheme),

      // Feedback
      snackBarTheme: _snackBarTheme(colorScheme),
      tooltipTheme: _tooltipTheme(colorScheme),
      badgeTheme: _badgeTheme(colorScheme),
      progressIndicatorTheme: _progressIndicatorTheme(colorScheme),

      // Misc
      dividerTheme: _dividerTheme(colorScheme),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      pageTransitionsTheme: _pageTransitionsTheme(),
      textSelectionTheme: _textSelectionTheme(colorScheme),
      scrollbarTheme: _scrollbarTheme(colorScheme),
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
    );
  }

  static ScrollbarThemeData _scrollbarTheme(ColorScheme colorScheme) {
    return ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(
        colorScheme.onSurface.withValues(alpha: 0.3),
      ),
      trackColor: WidgetStatePropertyAll(
        colorScheme.onSurface.withValues(alpha: 0.1),
      ),
      radius: const Radius.circular(AppSizes.radius8),
      thickness: const WidgetStatePropertyAll(6),
    );
  }

  static TextSelectionThemeData _textSelectionTheme(ColorScheme colorScheme) {
    return TextSelectionThemeData(
      cursorColor: colorScheme.primary,
      selectionColor: colorScheme.primary.withValues(alpha: 0.3),
      selectionHandleColor: colorScheme.primary,
    );
  }

  static PageTransitionsTheme _pageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      },
    );
  }

  static ProgressIndicatorThemeData _progressIndicatorTheme(
    ColorScheme colorScheme,
  ) {
    return ProgressIndicatorThemeData(
      color: colorScheme.primary,
      linearTrackColor: colorScheme.primaryContainer,
    );
  }

  static BadgeThemeData _badgeTheme(ColorScheme colorScheme) {
    return BadgeThemeData(
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // APP BAR
  // ═══════════════════════════════════════════════════════════════════════════

  static AppBarTheme _appBarTheme(ColorScheme colorScheme, bool isLight) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: colorScheme.surfaceTint,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
      systemOverlayStyle: isLight
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: AppColors.transparent,
              systemNavigationBarColor: colorScheme.surface,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: AppColors.transparent,
              systemNavigationBarColor: colorScheme.surface,
            ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUTTONS
  // ═══════════════════════════════════════════════════════════════════════════

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: AppSizes.paddingH24.copyWith(top: 14, bottom: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        backgroundColor: colorScheme.surfaceContainerLow,
        foregroundColor: colorScheme.primary,
        surfaceTintColor: colorScheme.surfaceTint,
        shadowColor: colorScheme.shadow,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
      ),
    );
  }

  static FilledButtonThemeData _filledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: AppSizes.paddingH24.copyWith(top: 14, bottom: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: AppSizes.paddingH24.copyWith(top: 14, bottom: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius12),
        ),
        side: BorderSide(color: colorScheme.outline),
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: AppSizes.paddingH16.copyWith(top: 12, bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius12),
        ),
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  static IconButtonThemeData _iconButtonTheme(ColorScheme colorScheme) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        highlightColor: colorScheme.primary.withValues(alpha: 0.08),
      ),
    );
  }

  static FloatingActionButtonThemeData _fabTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      elevation: 2,
      highlightElevation: 4,
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius16),
      ),
    );
  }

  static SegmentedButtonThemeData _segmentedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.secondaryContainer;
          }
          return colorScheme.surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onSecondaryContainer;
          }
          return colorScheme.onSurface;
        }),
        side: WidgetStatePropertyAll(BorderSide(color: colorScheme.outline)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius20),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CARDS & CONTAINERS
  // ═══════════════════════════════════════════════════════════════════════════

  static CardThemeData _cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      clipBehavior: Clip.antiAlias,
      margin: AppSizes.paddingAll8,
    );
  }

  static DrawerThemeData _drawerTheme(ColorScheme colorScheme) {
    return DrawerThemeData(
      elevation: 1,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(AppSizes.radius16),
        ),
      ),
    );
  }

  static BottomSheetThemeData _bottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radius24),
        ),
      ),
      dragHandleColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
      dragHandleSize: const Size(32, 4),
      showDragHandle: true,
    );
  }

  static DialogThemeData _dialogTheme(ColorScheme colorScheme) {
    return DialogThemeData(
      elevation: 6,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius24),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // NAVIGATION
  // ═══════════════════════════════════════════════════════════════════════════

  static NavigationBarThemeData _navigationBarTheme(ColorScheme colorScheme) {
    return NavigationBarThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      indicatorColor: colorScheme.primaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.onPrimaryContainer);
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant);
      }),
    );
  }

  static NavigationRailThemeData _navigationRailTheme(ColorScheme colorScheme) {
    return NavigationRailThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.primaryContainer,
      selectedIconTheme: IconThemeData(color: colorScheme.onPrimaryContainer),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
    );
  }

  static TabBarThemeData _tabBarTheme(ColorScheme colorScheme) {
    return TabBarThemeData(
      indicatorColor: colorScheme.primary,
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: colorScheme.outlineVariant,
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
    ColorScheme colorScheme,
  ) {
    return BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // INPUTS
  // ═══════════════════════════════════════════════════════════════════════════

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radius12),
      borderSide: BorderSide(color: colorScheme.outline),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      contentPadding: AppSizes.paddingAll16,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      disabledBorder: border.copyWith(
        borderSide: BorderSide(
          color: colorScheme.onSurface.withValues(alpha: 0.12),
        ),
      ),
      prefixIconColor: colorScheme.onSurfaceVariant,
      suffixIconColor: colorScheme.onSurfaceVariant,
    );
  }

  static SearchBarThemeData _searchBarTheme(ColorScheme colorScheme) {
    return SearchBarThemeData(
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerHigh),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      overlayColor: WidgetStatePropertyAll(
        colorScheme.primary.withValues(alpha: 0.08),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius28),
        ),
      ),
      padding: const WidgetStatePropertyAll(AppSizes.paddingH16),
      constraints: const BoxConstraints(minHeight: 56),
      hintStyle: WidgetStatePropertyAll(
        TextStyle(color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  static DropdownMenuThemeData _dropdownMenuTheme(ColorScheme colorScheme) {
    return DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        contentPadding: AppSizes.paddingH16,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
        surfaceTintColor: WidgetStatePropertyAll(colorScheme.surfaceTint),
        elevation: const WidgetStatePropertyAll(3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LISTS & TILES
  // ═══════════════════════════════════════════════════════════════════════════

  static ListTileThemeData _listTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius12),
      ),
      contentPadding: AppSizes.paddingH16.copyWith(top: 4, bottom: 4),
      iconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurface,
    );
  }

  static ExpansionTileThemeData _expansionTileTheme(ColorScheme colorScheme) {
    return ExpansionTileThemeData(
      backgroundColor: colorScheme.surface,
      collapsedBackgroundColor: colorScheme.surface,
      iconColor: colorScheme.onSurfaceVariant,
      collapsedIconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurface,
      collapsedTextColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius12),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius12),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MENUS
  // ═══════════════════════════════════════════════════════════════════════════

  static PopupMenuThemeData _popupMenuTheme(ColorScheme colorScheme) {
    return PopupMenuThemeData(
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius12),
      ),
    );
  }

  static MenuThemeData _menuTheme(ColorScheme colorScheme) {
    return MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
        surfaceTintColor: WidgetStatePropertyAll(colorScheme.surfaceTint),
        elevation: const WidgetStatePropertyAll(3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
          ),
        ),
        padding: const WidgetStatePropertyAll(AppSizes.paddingV8),
      ),
    );
  }

  static MenuBarThemeData _menuBarTheme(ColorScheme colorScheme) {
    return MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
        surfaceTintColor: WidgetStatePropertyAll(colorScheme.surfaceTint),
        elevation: const WidgetStatePropertyAll(0),
      ),
    );
  }

  static MenuButtonThemeData _menuButtonTheme(ColorScheme colorScheme) {
    return MenuButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(colorScheme.onSurface),
        overlayColor: WidgetStatePropertyAll(
          colorScheme.primary.withValues(alpha: 0.08),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PICKERS
  // ═══════════════════════════════════════════════════════════════════════════

  static DatePickerThemeData _datePickerTheme(ColorScheme colorScheme) {
    return DatePickerThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      headerBackgroundColor: colorScheme.primary,
      headerForegroundColor: colorScheme.onPrimary,
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.38);
        }
        return colorScheme.onSurface;
      }),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.primary;
      }),
      todayBorder: BorderSide(color: colorScheme.primary),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.onSurface;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius24),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  static TimePickerThemeData _timePickerTheme(ColorScheme colorScheme) {
    return TimePickerThemeData(
      backgroundColor: colorScheme.surface,
      hourMinuteColor: colorScheme.primaryContainer,
      hourMinuteTextColor: colorScheme.onPrimaryContainer,
      dayPeriodColor: colorScheme.primaryContainer,
      dayPeriodTextColor: colorScheme.onPrimaryContainer,
      dialBackgroundColor: colorScheme.surfaceContainerHighest,
      dialHandColor: colorScheme.primary,
      dialTextColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.onSurface;
      }),
      entryModeIconColor: colorScheme.onSurfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius24),
      ),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius12),
      ),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius8),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SELECTION CONTROLS
  // ═══════════════════════════════════════════════════════════════════════════

  static SwitchThemeData _switchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.surfaceContainerHighest;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.transparent;
        }
        return colorScheme.outline;
      }),
    );
  }

  static CheckboxThemeData _checkboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return AppColors.transparent;
      }),
      checkColor: WidgetStatePropertyAll(colorScheme.onPrimary),
      side: BorderSide(color: colorScheme.outline, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius4),
      ),
    );
  }

  static RadioThemeData _radioTheme(ColorScheme colorScheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
    );
  }

  static SliderThemeData _sliderTheme(ColorScheme colorScheme) {
    return SliderThemeData(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.primaryContainer,
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withValues(alpha: 0.12),
      valueIndicatorColor: colorScheme.primary,
    );
  }

  static ChipThemeData _chipTheme(ColorScheme colorScheme) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      selectedColor: colorScheme.primaryContainer,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
      padding: AppSizes.paddingH12.copyWith(top: 8, bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius8),
      ),
      side: BorderSide.none,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FEEDBACK
  // ═══════════════════════════════════════════════════════════════════════════

  static SnackBarThemeData _snackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorScheme.inverseSurface,
      actionTextColor: colorScheme.inversePrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius12),
      ),
      elevation: 4,
      insetPadding: AppSizes.paddingAll16,
    );
  }

  static TooltipThemeData _tooltipTheme(ColorScheme colorScheme) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(AppSizes.radius8),
      ),
      padding: AppSizes.paddingH12.copyWith(top: 8, bottom: 8),
      waitDuration: AppSizes.durationNormal,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MISC
  // ═══════════════════════════════════════════════════════════════════════════

  static DividerThemeData _dividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
      space: 1,
    );
  }
}
