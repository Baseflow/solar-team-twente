import 'package:flutter/material.dart';

import '../../../localizations/l10n.dart';
import 'live_view.dart';

/// {@template live_page}
/// Page to display the live data of the current Solarteam event, like the
/// location of the vehicle, the speed, battery level, etc.
/// {@endtemplate}
class LivePage extends StatelessWidget {
  /// {@macro live_page}
  const LivePage({super.key});

  /// The path of the dashboard page.
  static const String path = '/';

  /// The route name of the dashboard page.
  static const String routeName = 'LivePage';

  /// The destination for the [LivePage] route.
  ///
  /// This is necessary for the bottom navigation bar to display the correct
  /// icon and label for the page, as well as to navigate to the page.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.livePageTitle,
      selectedIcon: const Icon(Icons.sunny),
      icon: const Icon(Icons.sunny),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const LiveView();
  }
}
