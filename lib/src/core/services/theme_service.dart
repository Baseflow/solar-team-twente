import '../repositories/theme_repository.dart';
import '../types/types.dart';

/// The service to manage the theme settings.
/// This service is used to save and retrieve the theme mode from
/// the shared preferences.
class ThemeService {
  /// Creates a new instance of [ThemeService].
  ThemeService({required ThemeRepository themeRepository})
    : _themeRepository = themeRepository;

  final ThemeRepository _themeRepository;

  /// Saves the theme mode to the shared preferences.
  Future<void> saveThemeMode(AppThemeMode mode) async {
    await _themeRepository.setTheme(mode.name);
  }

  /// Gets the saved theme mode from the shared preferences.
  AppThemeMode getSavedThemeMode() {
    final String savedMode =
        _themeRepository.getTheme() ?? AppThemeMode.system.name;

    return AppThemeMode.values.firstWhere(
      (AppThemeMode e) => e.name == savedMode,
      orElse: () => AppThemeMode.system,
    );
  }
}
