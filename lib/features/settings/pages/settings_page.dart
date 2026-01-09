import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/core/theme/theme_provider.dart';
import 'package:flutter_riverpod_starter/l10n/provider/app_language_provider.dart';
import 'package:flutter_riverpod_starter/models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod_starter/utils/utils.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
    final language = ref.watch(appLanguageControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.ext.l10n.settingsPage)),
      body: ListView(
        children: [
          ListTile(
            title: Text(context.ext.l10n.theme),
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                ref
                    .read(themeControllerProvider.notifier)
                    .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
            leading: const Icon(Icons.brightness_6),
          ),
          ListTile(
            title: Text(context.ext.l10n.language),
            trailing: DropdownButton<AppLanguage>(
              value: language,
              onChanged: (AppLanguage? newValue) {
                if (newValue != null) {
                  ref
                      .read(appLanguageControllerProvider.notifier)
                      .setLanguage(newValue);
                }
              },
              items: AppLanguage.values.map<DropdownMenuItem<AppLanguage>>((
                AppLanguage value,
              ) {
                return DropdownMenuItem<AppLanguage>(
                  value: value,
                  child: Text(value.displayName),
                );
              }).toList(),
            ),
            leading: const Icon(Icons.language),
          ),
        ],
      ),
    );
  }
}
