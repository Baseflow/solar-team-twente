import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/src/ui/features/authentication/widgets/change_language_button.dart';
import 'package:solar_team_twente/src/ui/features/settings/cubit/language_cubit.dart';

import '../../helpers/material_app_helper.dart';

class MockLanguageCubit extends MockCubit<String> implements LanguageCubit {}

void main() {
  group('Change language button', () {
    late MockLanguageCubit mockLanguageCubit;

    setUp(() {
      mockLanguageCubit = MockLanguageCubit();
    });

    testWidgets('should display the EN language code', (
      WidgetTester tester,
    ) async {
      when(() => mockLanguageCubit.state).thenReturn('EN');
      when(() => mockLanguageCubit.getCountryCode()).thenReturn('EN');
      await tester.pumpWidget(
        MaterialAppHelper(
          child: BlocProvider<LanguageCubit>.value(
            value: mockLanguageCubit,
            child: const ChangeLanguageButton(),
          ),
        ),
      );

      expect(find.text('EN'), findsOneWidget);
    });
  });
}
