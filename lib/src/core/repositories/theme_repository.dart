/// Interface for creating a data-layer implementation to manage the theme.
abstract interface class ThemeRepository {
  /// Stores the [themeCode] that is being used by the app.
  Future<void> setTheme(String themeCode);

  /// Gets the theme that should be used by the app.
  String? getTheme();
}
