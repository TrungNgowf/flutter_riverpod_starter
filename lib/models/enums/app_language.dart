import 'dart:ui';

enum AppLanguage {
  en(displayName: 'English', locale: Locale('en')),
  vi(displayName: 'Tiếng Việt', locale: Locale('vi'));

  final String displayName;
  final Locale locale;

  const AppLanguage({required this.displayName, required this.locale});
}
