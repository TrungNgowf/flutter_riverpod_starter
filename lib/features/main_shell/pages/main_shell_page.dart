import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:flutter_riverpod_starter/router/app_router.dart';
import 'package:flutter_riverpod_starter/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavItem {
  final PageRouteInfo route;
  final IconData icon;
  final String label;
  final bool showBadge;

  const BottomNavItem({
    required this.route,
    required this.icon,
    required this.label,
    this.showBadge = false,
  });
}

@RoutePage()
class MainShellPage extends ConsumerWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<BottomNavItem> pages = [
      BottomNavItem(
        route: const HomeRoute(),
        icon: Iconsax.home,
        label: context.ext.l10n.homePage,
      ),
      BottomNavItem(
        route: const SearchRoute(),
        icon: Iconsax.search_normal,
        label: context.ext.l10n.searchPage,
      ),
      BottomNavItem(
        route: const NotificationsRoute(),
        icon: Iconsax.notification,
        label: context.ext.l10n.notificationPage,
      ),
      BottomNavItem(
        route: const SettingsRoute(),
        icon: Iconsax.setting_2,
        label: context.ext.l10n.settingsPage,
      ),
    ];
    return AutoTabsRouter(
      routes: pages.map((e) => e.route).toList(),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            child: const Icon(Iconsax.scanning),
            onPressed: () {
              context.router.push(const ScanRoute());
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            backgroundColor: context.ext.colors.primary,
            activeIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            itemCount: pages.length,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSizes.spacing4,
                children: [
                  Icon(
                    pages[index].icon,
                    size: AppSizes.iconMd,
                    color: isActive
                        ? context.ext.colors.onPrimary
                        : context.ext.colors.inversePrimary,
                  ),
                  Text(
                    pages[index].label,
                    style: context.ext.textTheme.labelSmall?.copyWith(
                      color: isActive
                          ? context.ext.colors.onPrimary
                          : context.ext.colors.inversePrimary,
                    ),
                  ),
                ],
              );
            },
            splashSpeedInMilliseconds: 0,
            leftCornerRadius: AppSizes.radiusLg,
            rightCornerRadius: AppSizes.radiusLg,
            height: AppSizes.bottomNavHeight,
          ),
        );
      },
    );
  }
}
