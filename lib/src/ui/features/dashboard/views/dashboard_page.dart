import 'package:flutter/material.dart';

import '../../../localizations/l10n.dart';
import 'dashboard_view.dart';

/// {@template dashboard_page}
/// Page to display the dashboard of the current Solarteam event.
///
/// Will show the current location of the vehicle for example, or the current
/// status of the vehicle, like speed, battery level, etc.
/// {@endtemplate}
class DashboardPage extends StatelessWidget {
  /// {@macro dashboard_page}
  const DashboardPage({super.key});

  /// The path of the dashboard page.
  static const String path = '/dashboard';

  /// The route name of the dashboard page.
  static const String routeName = 'Dashboard';

  /// The destination for the [DashboardPage] route.
  ///
  /// This is necessary for the bottom navigation bar to display the correct
  /// icon and label for the page, as well as to navigate to the page.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.dashboardPageTitle,
      selectedIcon: const Icon(Icons.dashboard),
      icon: const Icon(Icons.dashboard_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const DashboardView();
  }
}
