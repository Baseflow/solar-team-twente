/// The abstract class for the crashlytics repository.
abstract interface class CrashlyticsRepository {
  /// Initializes crash reporting.
  Future<void> initialize();

  /// Sets the user identifier.
  Future<void> setUserIdentifier(String identifier);

  /// Logs an error with the given [error] and [trace].
  Future<void> reportError(
    dynamic error,
    StackTrace? trace, {
    bool fatal = false,
  });
}
