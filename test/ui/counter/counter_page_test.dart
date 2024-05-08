import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_team_twente/src/ui/features/counter/cubit/counter_cubit.dart';
import 'package:solar_team_twente/src/ui/features/counter/view/counter_page.dart';

import '../../helpers/material_app_helper.dart';

void main() {
  testWidgets(
    'Should display title text `Counter`',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppHelper(
          child: CounterPage(),
        ),
      );

      expect(find.text('Counter'), findsOneWidget);
    },
  );

  testWidgets(
    'Should display `You have pushed the button this many times`',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppHelper(
          child: CounterPage(),
        ),
      );

      expect(
        find.text('You have pushed the button this many times:'),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should find FloatingActionButton',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppHelper(
          child: CounterPage(),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);

      expect(find.byIcon(Icons.add), findsOneWidget);
    },
  );

  testWidgets(
    'should increment the counter when the button is tapped',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialAppHelper(
          child: BlocProvider<CounterCubit>(
            create: (BuildContext context) => CounterCubit(),
            child: const CounterPage(),
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    },
  );
}
