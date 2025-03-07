import '../repositories/repositories.dart';

/// A service to manage analytics events.
class AnalyticsService {
  /// Creates a new instance of [AnalyticsService].
  AnalyticsService({required AnalyticsRepository analyticsRepository})
    : _analyticsRepository = analyticsRepository;

  /// The [AnalyticsRepository] to manage analytics events.
  final AnalyticsRepository _analyticsRepository;

  /// Initializes the analytics.
  Future<void> initialize() async {
    await _analyticsRepository.initialize();
  }

  /// Logs an analytics event with the given [name] and [params].
  /// The [name] parameter specifies the name of the event.
  /// The [params] parameter specifies additional parameters for the event.
  Future<void> logEvent({
    required String name,
    Map<String, Object>? params,
  }) async {
    await _analyticsRepository.logEvent(name: name, params: params);
  }

  /// Sets the user identifier for analytics.
  Future<void> setUserId(String identifier) async {
    await _analyticsRepository.setUserId(identifier);
  }

  /// Updates the user properties for analytics.
  Future<void> updateUserProperties(Map<String, dynamic> userProperties) async {
    await _analyticsRepository.updateUserProperties(userProperties);
  }
}
