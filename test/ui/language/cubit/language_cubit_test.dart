import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/settings/cubit/language_cubit.dart';

class MockLanguageService extends Mock implements LanguageService {}

void main() {
  group('LanguageCubit', () {
    late MockLanguageService mockLanguageService;

    setUp(() {
      mockLanguageService = MockLanguageService();
    });
    const String defaultLanguageCode = 'en';
    const String dutchLanguageCode = 'nl';

    blocTest<LanguageCubit, String>(
      'should fetch default language code',
      build: () {
        when(() => mockLanguageService.fetchLanguageCode()).thenAnswer((_) {
          return defaultLanguageCode;
        });
        return LanguageCubit(
          languageService: mockLanguageService,
          defaultLanguageCode: defaultLanguageCode,
        );
      },
      act: (LanguageCubit cubit) => cubit.fetchLanguage(),
      expect: () => <String>[defaultLanguageCode],
    );
    blocTest<LanguageCubit, String>(
      'should fetch NL language code',
      build: () {
        when(() => mockLanguageService.fetchLanguageCode()).thenAnswer((_) {
          return dutchLanguageCode;
        });
        return LanguageCubit(
          languageService: mockLanguageService,
          defaultLanguageCode: defaultLanguageCode,
        );
      },
      act: (LanguageCubit cubit) => cubit.fetchLanguage(),
      expect: () => <String>[dutchLanguageCode],
    );

    blocTest<LanguageCubit, String>(
      'should use default language code',
      build: () {
        when(() => mockLanguageService.saveLanguageCode(defaultLanguageCode))
            .thenAnswer((_) {
          return Future<String>.value(defaultLanguageCode);
        });
        return LanguageCubit(
          languageService: mockLanguageService,
          defaultLanguageCode: defaultLanguageCode,
        );
      },
      act: (LanguageCubit cubit) => cubit.changeLanguage(defaultLanguageCode),
      expect: () => <String>[defaultLanguageCode],
    );
    blocTest<LanguageCubit, String>(
      'should change to NL language code',
      build: () {
        when(() => mockLanguageService.saveLanguageCode(dutchLanguageCode))
            .thenAnswer((_) {
          return Future<String>.value(dutchLanguageCode);
        });
        return LanguageCubit(
          languageService: mockLanguageService,
          defaultLanguageCode: defaultLanguageCode,
        );
      },
      act: (LanguageCubit cubit) => cubit.changeLanguage(dutchLanguageCode),
      expect: () => <String>[dutchLanguageCode],
    );
    blocTest<LanguageCubit, String>(
      'should called getCountryCode once',
      build: () {
        when(() => mockLanguageService.getCountryCode(defaultLanguageCode))
            .thenReturn('GB');
        return LanguageCubit(
          languageService: mockLanguageService,
          defaultLanguageCode: defaultLanguageCode,
        );
      },
      act: (LanguageCubit cubit) => cubit.getCountryCode(),
      verify: (_) {
        verify(() => mockLanguageService.getCountryCode(defaultLanguageCode))
            .called(1);
      },
    );
    blocTest<LanguageCubit, String>(
      'should currentLocale return default language code',
      build: () => LanguageCubit(
        languageService: mockLanguageService,
        defaultLanguageCode: defaultLanguageCode,
      ),
      act: (LanguageCubit cubit) => cubit.currentLocale,
      verify: (LanguageCubit cubit) {
        expect(cubit.currentLocale.languageCode, defaultLanguageCode);
      },
    );
  });
}
