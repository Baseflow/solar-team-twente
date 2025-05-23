import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_team_twente/src/ui/layouts/slot_child_layout.dart';

import '../../helpers/material_app_helper.dart';

void main() {
  const MaterialAppHelper testLayout = MaterialAppHelper(
    child: SlotChildLayout(smallBody: Text('Small'), mediumBody: Text('Medium'), largeBody: Text('Large')),
  );

  // The device pixel ratio
  const double pixelRatio = 3;

  // Breakpoints
  const Size highEndOfSmall = Size(599 * pixelRatio, 800 * pixelRatio);
  const Size lowEndOfMedium = Size(600 * pixelRatio, 800 * pixelRatio);
  const Size highEndOfMedium = Size(839 * pixelRatio, 800 * pixelRatio);
  const Size lowEndOfLarge = Size(840 * pixelRatio, 800 * pixelRatio);

  group('SlotChildLayout', () {
    testWidgets('should show `Small` text on small screens', (WidgetTester tester) async {
      await tester.pumpWidget(testLayout);

      // GOOD WEATHER (just right, high end)
      tester.view.physicalSize = highEndOfSmall;
      await tester.pump();
      expect(find.text('Small'), findsOneWidget);

      // BAD WEATHER (too large)
      tester.view.physicalSize = lowEndOfMedium;
      await tester.pump();
      expect(find.text('Small'), findsNothing);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('should show `Medium` text on medium screens', (WidgetTester tester) async {
      await tester.pumpWidget(testLayout);

      // GOOD WEATHER (just right, low end)
      tester.view.physicalSize = lowEndOfMedium;
      await tester.pump();
      expect(find.text('Medium'), findsOneWidget);

      // GOOD WEATHER (just right, high end)
      tester.view.physicalSize = highEndOfMedium;
      await tester.pump();
      expect(find.text('Medium'), findsOneWidget);

      // BAD WEATHER (too small)
      tester.view.physicalSize = highEndOfSmall;
      await tester.pump();
      expect(find.text('Medium'), findsNothing);

      // BAD WEATHER (too large)
      tester.view.physicalSize = lowEndOfLarge;
      await tester.pump();
      expect(find.text('Medium'), findsNothing);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('should show `Large` text on larger screens', (WidgetTester tester) async {
      await tester.pumpWidget(testLayout);

      // GOOD WEATHER
      tester.view.physicalSize = lowEndOfLarge;
      await tester.pump();
      expect(find.text('Large'), findsOneWidget);

      // BAD WEATHER
      tester.view.physicalSize = highEndOfMedium;
      await tester.pump();
      expect(find.text('Large'), findsNothing);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('should show smallBody when mediumBody is null', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialAppHelper(child: SlotChildLayout(smallBody: Text('Small'))));

      tester.view.physicalSize = lowEndOfMedium;
      await tester.pump();
      expect(find.text('Small'), findsOneWidget);

      tester.view.physicalSize = highEndOfMedium;
      await tester.pump();
      expect(find.text('Small'), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('should show mediumBody when largeBody is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppHelper(
          child: SlotChildLayout(smallBody: Text('Small'), mediumBody: Text('Medium')),
        ),
      );

      tester.view.physicalSize = lowEndOfLarge;
      await tester.pump();
      expect(find.text('Medium'), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('should show smallBody when mediumBody and largeBody are null', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialAppHelper(child: SlotChildLayout(smallBody: Text('Small'))));

      tester.view.physicalSize = lowEndOfLarge;
      await tester.pump();
      expect(find.text('Small'), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });
  });
}
