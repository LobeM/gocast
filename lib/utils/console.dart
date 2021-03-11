import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Console related functions like logging.
class Console {
  /// Log to console.
  static void log(String tag, String msg, {dynamic error}) {
    // Application was compiled in debug mode?
    if (kDebugMode) {
      developer.log('$msg', time: DateTime.now(), name: tag, error: error);
      // } else if (kLogzioToken.isNotEmpty) {
      //   if (error != null) {
      //     Logger(kAppVersion).severe(msg);
      //   } else {
      //     Logger(kAppVersion).info(msg);
      //   }
      // }
    }
  }
}
