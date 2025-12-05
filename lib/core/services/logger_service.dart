import 'dart:developer';
import 'package:logger/logger.dart';

class LoggerService {
  static final LoggerService _default = LoggerService._internal();

  factory LoggerService() => _default;

  final Logger _logger;

  LoggerService._internal({Logger? logger}) : _logger = logger ?? Logger();

  // ===== Static methods (use for default logger) =====
  static void defaultDebug(dynamic message) => _default._logger.d(message);

  static void defaultInfo(dynamic message) => _default._logger.i(message);

  static void defaultWarning(dynamic message) => _default._logger.w(message);

  static void defaultError(dynamic message, [dynamic error, StackTrace? st]) =>
      _default._logger.e(message, error: error, stackTrace: st);

  static void dev(String message, {String name = "App"}) {
    log(message, name: name);
  }

  // ===== Instance methods (use for custom logger) =====
  // if don't set logger in constructor, this methods are same as default methods
  void debug(dynamic message) => _logger.d(message);

  void info(dynamic message) => _logger.i(message);

  void warning(dynamic message) => _logger.w(message);

  void error(dynamic message, [dynamic error, StackTrace? st]) =>
      _logger.e(message, error: error, stackTrace: st);
}
