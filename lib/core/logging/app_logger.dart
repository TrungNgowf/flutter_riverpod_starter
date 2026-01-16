import 'dart:developer';
import 'package:flutter_riverpod_starter/core/environments/env.dart';
import 'package:flutter_riverpod_starter/models/models.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_logger.g.dart';

@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) {
  final config = switch (Env.flavor) {
    Flavor.develop => Logger(
      filter: DevelopmentFilter(),
      printer: PrettyPrinter(),
      output: ConsoleOutput(),
      level: Level.debug,
    ),
    Flavor.staging => Logger(
      filter: DevelopmentFilter(),
      printer: PrettyPrinter(),
      output: ConsoleOutput(),
      level: Level.info,
    ),
    Flavor.production => Logger(
      filter: ProductionFilter(),
      printer: SimplePrinter(),
      output: ConsoleOutput(),
      level: Level.warning,
    ),
  };
  return AppLogger(config);
}

class AppLogger {
  final Logger _logger;

  const AppLogger(this._logger);

  void debug(dynamic message) {
    _logger.d(message);
  }

  void dev(String message, {String name = "App"}) {
    log(message, name: name);
  }

  void error(dynamic message, [error, StackTrace? st]) {
    _logger.e(message, error: error, stackTrace: st);
  }

  void fatal(dynamic message, [error, StackTrace? st]) {
    _logger.e(message, error: error, stackTrace: st);
  }

  void info(dynamic message) {
    _logger.i(message);
  }

  void warning(dynamic message) {
    _logger.w(message);
  }
}
