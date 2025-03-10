import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

/// {@template top_three_ranking}
/// A [TopThreeRankingView] displaying the top three ranking of the team
/// in the leaderboard.
/// {@endtemplate}
class TopThreeRankingView extends StatelessWidget {
  /// {@macro top_three_ranking}
  const TopThreeRankingView({required this.team, super.key});

  final RaceTeam team;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = <Color>[Colors.amber, Colors.grey, Colors.brown];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors[team.position - 1], width: Sizes.s2),
        borderRadius: BorderRadius.circular(Sizes.s4),
      ),
      padding: const EdgeInsets.all(Sizes.s12),
      margin: const EdgeInsets.only(bottom: Sizes.s12),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Sizes.s96,
            child: Text(
              '${team.position}',
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors[team.position - 1],
              ),
            ),
          ),
          const GutterSmall(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  team.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${team.totalDrivenKilometers} km'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
