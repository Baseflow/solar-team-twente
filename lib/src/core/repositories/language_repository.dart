/// Interface for creating a data-layer implementation to manage the language.
abstract interface class LanguageRepository {
  /// Stores the [languageCode] that is being used by the app.
  Future<void> setLanguage(String languageCode);

  /// Gets the language that should be used by the app.
  String? getLanguage();
}
