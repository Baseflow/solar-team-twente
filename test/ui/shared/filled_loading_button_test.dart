import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_team_twente/src/ui/features/shared/widgets/filled_loading_button.dart';

void main() {
  group('FilledLoadingButton', () {
    testWidgets('should display only text when not loading.', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FilledLoadingButton(buttonText: 'Test Button', onPressed: () {}, isLoading: false),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should display a circular loading indicator and text when loading.', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilledLoadingButton(buttonText: 'Test Button', onPressed: () {}, isLoading: true),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should be disabled when loading.', (WidgetTester tester) async {
      bool buttonPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: FilledLoadingButton(buttonText: 'Test Button', onPressed: () => buttonPressed = true, isLoading: true),
        ),
      );

      final Finder button = find.byType(FilledButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      expect(buttonPressed, false);
    });

    testWidgets('should be enabled when not loading.', (WidgetTester tester) async {
      bool buttonPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: FilledLoadingButton(buttonText: 'Test Button', onPressed: () => buttonPressed = true, isLoading: false),
        ),
      );

      final Finder button = find.byType(FilledButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      expect(buttonPressed, true);
    });
  });
}
