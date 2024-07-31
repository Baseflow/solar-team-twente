import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../constants/sizes_constants.dart';
import '../../leaderboard/leaderboard_preview_container.dart';
import '../../team/team_card.dart';

/// {@template dashboard_view}
/// The UI for the dashboard page, displaying the most important information
/// during the race.
/// {@endtemplate}
class DashboardView extends StatelessWidget {
  /// {@macro dashboard_view}
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LeaderboardPreviewContainer(),
              GutterLarge(),
              TeamCard(),
            ],
          ),
        ),
      ),
    );
  }
}
