import 'package:shared_preferences/shared_preferences.dart';

import '../../../core.dart';

/// A repository to manage the language of the app.
class SharedPreferencesLanguageRepository implements LanguageRepository {
  /// Creates a new instance of [SharedPreferencesLanguageRepository].
  SharedPreferencesLanguageRepository({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  /// The [SharedPreferences] to manage shared preferences.
  final SharedPreferences _sharedPreferences;

  static const String _key = 'userLanguage';

  @override
  Future<void> setLanguage(String languageCode) async {
    await _sharedPreferences.setString(_key, languageCode);
  }

  @override
  String? getLanguage() {
    return _sharedPreferences.getString(_key);
  }
}
