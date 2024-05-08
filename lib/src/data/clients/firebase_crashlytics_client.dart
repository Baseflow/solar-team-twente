import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../core/repositories/repositories.dart';

/// Provides Crashlytics functionality.
class FirebaseCrashlyticsClient implements CrashlyticsRepository {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Initializes Crashlytics.
  ///
  /// If the app is running in debug mode, crashlytics collection is disabled.
  /// Otherwise, crashlytics collection is enabled.
  ///
  /// If crashlytics collection is enabled, Flutter errors are recorded and
  /// platform errors are reported as fatal crashes.
  @override
  Future<void> initialize() async {
    if (kDebugMode) {
      await _crashlytics.setCrashlyticsCollectionEnabled(false);
    } else {
      await _crashlytics.setCrashlyticsCollectionEnabled(true);
    }

    if (_crashlytics.isCrashlyticsCollectionEnabled) {
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        log(details.exceptionAsString(), stackTrace: details.stack);
      };

      // Pass all uncaught asynchronous errors that aren't handled by the
      // Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        reportError(error, stack, fatal: true);
        return true;
      };
    }
  }

  /// Sets the user identifier for Crashlytics.
  @override
  Future<void> setUserIdentifier(String identifier) async {
    await _crashlytics.setUserIdentifier(identifier);
  }

  /// Reports an error to Crashlytics.
  ///
  /// The [error] parameter with the error object.
  /// The [trace] parameter with the stack trace associated with the error.
  /// The [fatal] parameter indicates whether the error is fatal or not.
  @override
  Future<void> reportError(
    dynamic error,
    StackTrace? trace, {
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(error, trace, fatal: fatal);
  }
}
