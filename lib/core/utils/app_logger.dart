import 'package:logger/logger.dart';

class AppLogger {
  const AppLogger(this._logger);

  final Logger _logger;

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
