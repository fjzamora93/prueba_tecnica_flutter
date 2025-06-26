import 'package:flutter/foundation.dart';

class Log {
  static void s(String message) {
    if (kDebugMode) print('🟢 SUCCESS: $message');
  }

  static void i(String message) {
    if (kDebugMode) print('🔵 INFO: $message');
  }

  static void d(String message) {
    if (kDebugMode) print('🟣 DEBUG: $message');
  }

  static void w(String message) {
    if (kDebugMode) print('🟠 WARNING: $message');
  }

  static void e(String message) {
    if (kDebugMode) print('🔴 ERROR: $message');
  }
}

