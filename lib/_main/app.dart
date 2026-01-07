import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/core/core.dart';
import 'package:flutter_riverpod_starter/core/theme/theme_provider.dart';
import 'package:flutter_riverpod_starter/l10n/app_localizations.dart';
import 'package:flutter_riverpod_starter/models/models.dart';
import 'package:flutter_riverpod_starter/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppRoot {
  static Future startApplication(Flavor flavor) async {
    WidgetsFlutterBinding.ensureInitialized();
    Env.flavor = flavor;
    runApp(ProviderScope(child: MyApp()));
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return MaterialApp(
      title: 'TurnG App',
      debugShowCheckedModeBanner: false,
      locale: AppLanguage.en.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: _buildRootPage(),
    );
  }

  StatefulWidget _buildRootPage() {
    return Env.isProd
        ? const MyHomePage()
        : Banner(
            message: Env.flavor.name.toUpperCase(),
            location: BannerLocation.topEnd,
            child: const MyHomePage(),
          );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _onClick() {
    setState(() {
      ref.read(themeControllerProvider.notifier).toggleTheme();
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.ext.l10n.helloWorld)),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(context.ext.l10n.countPushed(_counter)),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClick,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
