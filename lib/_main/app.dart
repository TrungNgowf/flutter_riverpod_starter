import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:flutter_riverpod_starter/core/theme/theme_provider.dart';
import 'package:flutter_riverpod_starter/l10n/app_localizations.dart';
import 'package:flutter_riverpod_starter/l10n/provider/app_language_provider.dart';
import 'package:flutter_riverpod_starter/models/models.dart';
import 'package:flutter_riverpod_starter/router/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppRoot {
  static Future startApplication(Flavor flavor) async {
    WidgetsFlutterBinding.ensureInitialized();
    Env.flavor = flavor;
    runApp(ProviderScope(child: MyApp()));
  }
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final language = ref.watch(appLanguageControllerProvider);

    return MaterialApp.router(
      title: 'TurnG App',
      debugShowCheckedModeBanner: Env.flavor != Flavor.production,
      locale: language.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: _appRouter.config(),
    );
  }

  // StatefulWidget _buildRootPage() {
  //   return Env.isProd
  //       ? const MyHomePage()
  //       : Banner(
  //           message: Env.flavor.name.toUpperCase(),
  //           location: BannerLocation.topEnd,
  //           child: const MyHomePage(),
  //         );
  // }
}
