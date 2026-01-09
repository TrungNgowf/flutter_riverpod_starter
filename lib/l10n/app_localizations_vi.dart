// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get helloWorld => 'Xin chào Thế Giới!';

  @override
  String countPushed(int count) {
    return 'Bạn đã nhấn nút $count lần:';
  }

  @override
  String get homePage => 'Trang chủ';

  @override
  String get searchPage => 'Tìm kiếm';

  @override
  String get settingsPage => 'Cài đặt';

  @override
  String get notificationPage => 'Thông báo';

  @override
  String get scanPage => 'Quét mã';

  @override
  String get theme => 'Chủ đề';

  @override
  String get language => 'Ngôn ngữ';
}
