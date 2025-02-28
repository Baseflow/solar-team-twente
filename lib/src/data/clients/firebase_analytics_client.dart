import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../core/repositories/analytics_repository.dart';

/// Handles analytics events using Firebase Analytics.
class FirebaseAnalyticsClient implements AnalyticsRepository {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Initializes the analytics.
  ///
  /// If the app is not in debug mode, analytics collection will be disabled.
  /// Otherwise, analytics collection will be enabled.
  @override
  Future<void> initialize() async {
    if (!kDebugMode) {
      await _analytics.setAnalyticsCollectionEnabled(false);
    } else {
      await _analytics.setAnalyticsCollectionEnabled(true);
    }
    await _analytics.logAppOpen();
  }

  /// Logs an analytics event with the given [name] and [params].
  ///
  /// The [name] parameter specifies the name of the event.
  /// The [params] parameter specifies additional parameters for the event.
  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? params,
  }) async {
    await FirebaseAnalytics.instance.logEvent(name: name, parameters: params);
  }

  /// Sets the user identifier for analytics.
  ///
  /// The [identifier] parameter specifies the user identifier.
  @override
  Future<void> setUserId(String identifier) async =>
      _analytics.setUserId(id: identifier);

  /// Updates the user properties for analytics.
  @override
  Future<void> updateUserProperties(Map<String, dynamic> userProperties) async {
    await _analytics.setDefaultEventParameters(userProperties);
  }
}
