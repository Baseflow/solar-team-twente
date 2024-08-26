import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core.dart';
import '../../../../constants/sizes_constants.dart';
import '../../cubit/leaderboard_preview_cubit.dart';
import '../../widgets/top_three_leaderboard_view.dart';

/// {@template overall_ranking_tab}
/// The view displaying the [OverallRankingTab] of the  event.
/// {@endtemplate}
class OverallRankingTab extends StatelessWidget {
  /// {@macro overall_ranking_tab}
  const OverallRankingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardPreviewCubit, LeaderboardPreviewState>(
      builder: (BuildContext context, LeaderboardPreviewState state) {
        assert(
          state is LeaderboardPreviewLoaded,
          'State has to be of type `LeaderboardPreviewLoaded` at this point.',
        );
        final LeaderboardPreviewLoaded loadedState =
            state as LeaderboardPreviewLoaded;
        final List<RaceTeam> leaderboard = loadedState.leaderboard;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: Sizes.s12),
              ...leaderboard.take(3).map(
                    (RaceTeam team) => TopThreeRanking(
                      team: team,
                      position: leaderboard.indexOf(team) + 1,
                    ),
                  ),
              const SizedBox(height: Sizes.s12),
              ...leaderboard.skip(3).map(
                    (RaceTeam team) => LeaderboardPosition(
                      team: team,
                      racePosition: leaderboard.indexOf(team) + 1,
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}

class LeaderboardPosition extends StatelessWidget {
  const LeaderboardPosition({
    required this.team,
    required this.racePosition,
    super.key,
  });

  final RaceTeam team;
  final int racePosition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Sizes.s32,
            child: Text(
              racePosition.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(team.name),
          ),
          Text(
            '${team.totalDrivenKilometers} km',
          ),
        ],
      ),
    );
  }
}
