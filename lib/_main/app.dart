import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/core/core.dart';
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
    return MaterialApp(
      title: 'TurnG App',
      debugShowCheckedModeBanner: false,
      locale: AppLanguage.en.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Env.isProd
          ? const MyHomePage()
          : Banner(
              message: Env.flavor.name.toUpperCase(),
              location: BannerLocation.topEnd,
              child: const MyHomePage(),
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.ext.l10n.helloWorld),
      ),
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
