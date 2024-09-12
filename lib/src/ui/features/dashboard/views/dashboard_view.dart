import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/sizes_constants.dart';
import '../../../localizations/l10n.dart';
import '../../leaderboard/leaderboard_preview_container.dart';
import '../../team/team_card.dart';

/// {@template dashboard_view}
/// The UI for the dashboard page, displaying the most important information
/// during the race.
/// {@endtemplate}
class DashboardView extends StatelessWidget {
  /// {@macro dashboard_view}
  const DashboardView({super.key});

  static const String _urlString =
      'https://www.polarsteps.com/SolarTeamTwente/12350380-sasol-solar-challenge';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LeaderboardPreviewContainer(),
              const GutterLarge(),
              const TeamCard(),
              const GutterLarge(),
              Center(
                child: FilledButton.icon(
                  onPressed: () async {
                    final Uri uri = Uri.parse(_urlString);
                    await launchUrl(uri);
                  },
                  icon: const Icon(Icons.open_in_new_rounded),
                  iconAlignment: IconAlignment.end,
                  label: Text(context.l10n.polarstepsCallToAction),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
