/// The abstract class for the analytics repository.
abstract interface class AnalyticsRepository {
  /// Initializes the analytics.
  Future<void> initialize();

  /// Logs an analytics event with the given [name] and [params].
  Future<void> logEvent({required String name, Map<String, Object?>? params});

  /// Sets the user identifier for analytics.
  Future<void> setUserId(String identifier);

  /// Updates the user properties for analytics.
  Future<void> updateUserProperties(Map<String, dynamic> userProperties);
}
