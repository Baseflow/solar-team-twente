import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_team_twente/src/ui/navigation/navigation_error_page.dart';

import '../../helpers/material_app_helper.dart';

void main() {
  testWidgets(
    'NavigationErrorPage should display its content correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppHelper(
          child: NavigationErrorPage(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Whooops'), findsOneWidget);

      expect(find.byType(Lottie), findsOneWidget);

      expect(
        find.textContaining(
          'The page you are looking for has not been found (yet).',
        ),
        findsOneWidget,
      );
    },
  );
}
