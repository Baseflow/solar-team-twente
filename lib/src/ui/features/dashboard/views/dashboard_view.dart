import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/state_message_view.dart';

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
        body: StateMessageView(
          asset: ConstrainedBox(
            constraints: BoxConstraints.loose(const Size.fromHeight(400)),
            child: Lottie.asset(
              Assets.animations.notFound,
              fit: BoxFit.fitHeight,
            ),
          ),
          message: context.l10n.soonAvailableMessage,
        ),
      ),
    );
  }
}
