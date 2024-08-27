import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../cubit/leaderboard_preview_cubit.dart';
import '../widgets/top_three_leaderboard_view.dart';

/// {@template overall_ranking_tab}
/// The view displaying the [OverallLeaderboardView] of the  event.
/// {@endtemplate}
class OverallLeaderboardView extends StatelessWidget {
  /// {@macro overall_ranking_tab}
  const OverallLeaderboardView({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: Sizes.s12),
                ...leaderboard.take(3).map(
                      (RaceTeam team) => TopThreeRankingView(
                        team: team,
                      ),
                    ),
                const SizedBox(height: Sizes.s12),
                ...leaderboard.skip(3).map(
                      (RaceTeam team) => LeaderboardPosition(
                        team: team,
                      ),
                    ),
                const SizedBox(height: Sizes.s12),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LeaderboardPosition extends StatelessWidget {
  const LeaderboardPosition({
    required this.team,
    super.key,
  });

  final RaceTeam team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.s16),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Sizes.s32,
            child: Text(
              team.position.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(team.name),
          ),
          Text(
            '${team.totalDrivenKilometers} km',
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
