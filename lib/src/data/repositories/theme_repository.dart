import 'package:shared_preferences/shared_preferences.dart';

import '../../../core.dart';

/// A repository to manage the theme of the app.
class SharedPreferencesThemeRepository implements ThemeRepository {
  /// Creates a new instance of [SharedPreferencesThemeRepository].
  SharedPreferencesThemeRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  /// The [SharedPreferences] to manage shared preferences.
  final SharedPreferences _sharedPreferences;

  static const String _key = 'app_theme';

  @override
  Future<void> setTheme(String themeCode) async {
    await _sharedPreferences.setString(_key, themeCode);
  }

  @override
  String? getTheme() {
    return _sharedPreferences.getString(_key);
  }
}
