import 'package:flutter/material.dart';

import '../../../localizations/l10n.dart';

/// {@template dashboard_view}
/// The UI for the dashboard page, displaying the most important information
/// during the race.
/// {@endtemplate}
class DashboardView extends StatelessWidget {
  /// {@macro dashboard_view}
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.dashboardPageTitle),
        ),
        body: Container(),
      ),
    );
  }
}
