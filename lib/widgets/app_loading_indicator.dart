import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'
    as loading_lib;

import '../core/theme/app_colors.dart';
import '../core/theme/app_sizes.dart';

/// Unified loading indicator widget for the app.
///
/// Usage:
/// ```dart
/// // Screen loading (center of screen)
/// AppLoading.screen(message: 'Đang tải...')
///
/// // Load more in list
/// AppLoading.loadMore()
///
/// // Inline loading (small, for buttons/text)
/// AppLoading.inline()
///
/// // Overlay loading (covers content)
/// AppLoading.overlay(
///   isLoading: true,
///   child: MyContent(),
/// )
/// ```
class AppLoading extends StatelessWidget {
  const AppLoading._({super.key, required this.size, this.color, this.message});

  /// Loading indicator cho toàn màn hình
  factory AppLoading.screen({
    Key? key,
    double size = 48,
    Color? color,
    String? message,
  }) {
    return _ScreenLoading(key: key, size: size, color: color, message: message);
  }

  /// Loading indicator cho load more trong list
  factory AppLoading.loadMore({
    Key? key,
    double size = 32,
    Color? color,
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: AppSizes.spacing16,
    ),
  }) {
    return _LoadMoreLoading(
      key: key,
      size: size,
      color: color,
      padding: padding,
    );
  }

  /// Loading indicator nhỏ gọn (inline)
  factory AppLoading.inline({Key? key, double size = 20, Color? color}) {
    return AppLoading._(key: key, size: size, color: color);
  }

  /// Loading overlay phủ lên content
  static Widget overlay({
    Key? key,
    required bool isLoading,
    required Widget child,
    double size = 48,
    Color? color,
    Color? backgroundColor,
    String? message,
  }) {
    return _OverlayLoading(
      key: key,
      isLoading: isLoading,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      message: message,
      child: child,
    );
  }

  final double size;
  final Color? color;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? Theme.of(context).colorScheme.primary;

    return loading_lib.LoadingAnimationWidget.waveDots(
      color: indicatorColor,
      size: size,
    );
  }
}

class _ScreenLoading extends AppLoading {
  const _ScreenLoading({
    super.key,
    required super.size,
    super.color,
    super.message,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? Theme.of(context).colorScheme.primary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loading_lib.LoadingAnimationWidget.fourRotatingDots(
            color: indicatorColor,
            size: size,
          ),
          if (message != null) ...[
            const SizedBox(height: AppSizes.spacing16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _LoadMoreLoading extends AppLoading {
  const _LoadMoreLoading({
    super.key,
    required super.size,
    super.color,
    required this.padding,
  }) : super._();

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? Theme.of(context).colorScheme.primary;

    return Padding(
      padding: padding,
      child: Center(
        child: loading_lib.LoadingAnimationWidget.progressiveDots(
          color: indicatorColor,
          size: size,
        ),
      ),
    );
  }
}

class _OverlayLoading extends StatelessWidget {
  const _OverlayLoading({
    super.key,
    required this.isLoading,
    required this.child,
    required this.size,
    this.color,
    this.backgroundColor,
    this.message,
  });

  final bool isLoading;
  final Widget child;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: backgroundColor ?? AppColors.overlayMedium,
              child: AppLoading.screen(
                size: size,
                color: color ?? AppColors.white,
                message: message,
              ),
            ),
          ),
      ],
    );
  }
}
