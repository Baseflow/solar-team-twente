import 'package:flutter/material.dart';

import '../../../localizations/l10n.dart';
import 'leaderboard_view.dart';

/// {@template leaderboard_page}
/// Page to display the leaderboard of the  event.
/// Will show the current place of the teams, as well as the total distance and
/// place by the teams in the event.
/// {@endtemplate}
class LeaderboardPage extends StatelessWidget {
  /// {@macro leaderboard_page}
  const LeaderboardPage({super.key});

  /// The path of the leaderboard page.
  static const String path = 'leaderboard';

  /// The route name of the leaderboard page.
  static const String routeName = 'Leaderboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.leaderboardTitle)),
      body: const LeaderboardView(),
    );
  }
}
