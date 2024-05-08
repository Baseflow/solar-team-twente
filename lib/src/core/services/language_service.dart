import '../repositories/repositories.dart';

/// A service to manage the language of the app.
class LanguageService {
  /// Creates a new instance of [LanguageService].
  LanguageService({
    required LanguageRepository languageRepository,
  }) : _languageRepository = languageRepository;

  /// The [LanguageRepository] to manage shared preferences.
  final LanguageRepository _languageRepository;

  /// Saves the given [languageCode] as the language of the app.
  Future<void> saveLanguageCode(String languageCode) async {
    await _languageRepository.setLanguage(languageCode);
  }

  /// Fetches the language of the app.
  String? fetchLanguageCode() {
    return _languageRepository.getLanguage();
  }

  /// Returns the country code of the given [languageCode].
  String getCountryCode(String languageCode) {
    if (languageCode == 'en') {
      return 'GB';
    } else {
      return languageCode;
    }
  }
}
