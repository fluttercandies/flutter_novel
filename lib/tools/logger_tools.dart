// ignore_for_file: depend_on_referenced_packages

import 'package:logger/logger.dart';

/// 日志工具
class LoggerTools {
  /// 日志
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      // Should each log print contain a timestamp
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  /// 获取logger
  static Logger get looger => _logger;
}
