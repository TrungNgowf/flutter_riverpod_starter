import 'package:auto_route/auto_route.dart';

import '../features/main_shell/pages/main_shell_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainShellRoute.page, initial: true),
  ];
}
