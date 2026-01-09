import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod_starter/features/home/pages/home_page.dart';
import 'package:flutter_riverpod_starter/features/notifications/pages/notifications_page.dart';
import 'package:flutter_riverpod_starter/features/scan/pages/scan_page.dart';
import 'package:flutter_riverpod_starter/features/search/pages/search_page.dart';
import 'package:flutter_riverpod_starter/features/settings/pages/settings_page.dart';

import '../features/main_shell/pages/main_shell_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainShellRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: NotificationsRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: ScanRoute.page),
  ];
}
