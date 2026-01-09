import 'package:flutter_riverpod_starter/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_language_provider.g.dart';

@riverpod
class AppLanguageController extends _$AppLanguageController { 
  @override
  AppLanguage build() {
    return AppLanguage.en;
  }

  void setLanguage(AppLanguage language) {
    state = language;
  }
}
