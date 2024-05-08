import '../repositories/repositories.dart';

/// A service to manage Crashlytics events.
class CrashlyticsService {
  /// Creates a new instance of [CrashlyticsService].
  CrashlyticsService({
    required CrashlyticsRepository crashlyticsRepository,
  }) : _crashlyticsRepository = crashlyticsRepository;

  /// The [CrashlyticsRepository] to manage Crashlytics events.
  final CrashlyticsRepository _crashlyticsRepository;

  /// Initializes the Crashlytics.
  Future<void> initialize() async {
    await _crashlyticsRepository.initialize();
  }

  /// Sets the user identifier for Crashlytics.
  Future<void> setUserIdentifier(String identifier) async {
    await _crashlyticsRepository.setUserIdentifier(identifier);
  }

  /// Reports an error to Crashlytics.
  Future<void> reportError(
    dynamic error,
    StackTrace? trace, {
    bool fatal = false,
  }) async {
    await _crashlyticsRepository.reportError(error, trace, fatal: fatal);
  }
}
