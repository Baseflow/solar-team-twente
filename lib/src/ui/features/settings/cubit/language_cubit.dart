import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../../../localizations/generated/app_localizations.dart';

/// Manages the [Locale] of the app.
class LanguageCubit extends Cubit<String> {
  /// Creates a new instance of [LanguageCubit].
  LanguageCubit({
    required LanguageService languageService,
    required String defaultLanguageCode,
  })  : _languageService = languageService,
        _defaultLanguageCode = defaultLanguageCode,
        super(defaultLanguageCode);

  /// The [LanguageService] to manage the language of the app.
  final LanguageService _languageService;

  final String _defaultLanguageCode;

  /// Changes the language of the app.
  Future<void> changeLanguage(String languageCode) async {
    await _languageService.saveLanguageCode(languageCode);
    emit(languageCode);
  }

  /// Fetches the language from the service and updates the state.
  Future<void> fetchLanguage() async {
    final String? fetchedLanguageCode = _languageService.fetchLanguageCode();

    final String languageCode = <String?>[
      fetchedLanguageCode,
      _defaultLanguageCode,
      'en',
    ].firstWhere(
      _isSupportedLanguage,
      orElse: () => AppLocalizations.supportedLocales.first.languageCode,
    )!;

    emit(languageCode);
  }

  /// The current [Locale] of the app.
  Locale get currentLocale => AppLocalizations.supportedLocales.firstWhere(
        (Locale locale) => locale.languageCode == state,
      );

  bool _isSupportedLanguage(String? languageCode) {
    return AppLocalizations.supportedLocales.any(
      (Locale locale) => locale.languageCode == languageCode,
    );
  }

  /// Returns the country code of the current language.
  String getCountryCode() {
    return _languageService.getCountryCode(state);
  }
}
