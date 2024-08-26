import 'package:flutter/material.dart';

import '../../../../core/entities/race/race_team.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

/// {@template top_three_ranking}
/// A [TopThreeRanking] displaying the top three ranking of the team
/// in the leaderboard.
/// {@endtemplate}
class TopThreeRanking extends StatelessWidget {
  /// {@macro top_three_ranking}
  const TopThreeRanking({
    required this.team,
    required this.position,
    super.key,
  });

  final RaceTeam team;
  final int position;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = <Color>[
      Colors.amber,
      Colors.grey,
      Colors.brown,
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Sizes.s4),
      decoration: BoxDecoration(
        border: Border.all(color: colors[position - 1], width: Sizes.s2),
        borderRadius: BorderRadius.circular(Sizes.s4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s12),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: Sizes.s96,
              child: Text(
                '$position',
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors[position - 1],
                ),
              ),
            ),
            const SizedBox(width: Sizes.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    team.name,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${team.totalDrivenKilometers} km',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
