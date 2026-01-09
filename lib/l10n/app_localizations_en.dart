// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String countPushed(int count) {
    return 'You have pushed the button $count times:';
  }

  @override
  String get homePage => 'Home';

  @override
  String get searchPage => 'Search';

  @override
  String get settingsPage => 'Settings';

  @override
  String get notificationPage => 'Notification';

  @override
  String get scanPage => 'Scan';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';
}
