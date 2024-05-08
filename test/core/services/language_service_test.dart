import 'package:solar_team_twente/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLanguageRepository extends Mock implements LanguageRepository{}
void main() {

  test('should return GB language code', () {
    final LanguageService languageService = LanguageService(
      languageRepository: MockLanguageRepository(),
    );

    const String languageCode = 'en';
    final String countryCode = languageService.getCountryCode(languageCode);

    expect(countryCode, 'GB');
  });

  test('should return NL language code', () {
    final LanguageService languageService = LanguageService(
      languageRepository: MockLanguageRepository(),
    );

    const String languageCode = 'nl';
    final String countryCode = languageService.getCountryCode(languageCode);

    expect(countryCode, 'nl');
  });
}
