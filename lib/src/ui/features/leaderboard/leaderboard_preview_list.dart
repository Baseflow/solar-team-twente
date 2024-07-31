import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';
import '../../constants/sizes_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../localizations/l10n.dart';
import 'cubit/leaderboard_preview_cubit.dart';
import 'views/leaderboard_preview_loaded_view.dart';

/// {@template leaderboard_preview_list}
/// Contains a list of the top 3 users in the leaderboard.
///
/// Also displays the Solarteam's positions if they are not in the top 3.
/// {@endtemplate}
class LeaderboardPreviewList extends StatelessWidget {
  /// {@macro leaderboard_preview_list}
  const LeaderboardPreviewList({super.key});

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
        final RaceTeam solarTeamTwente = loadedState.solarTeamTwente;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              context.l10n.leaderboardTitle,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: Sizes.s4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.s8),
              child: Text(
                context.l10n.distanceCovered,
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(height: Sizes.s12),
            if (solarTeamTwente.position > 3) ...<Widget>[
              LeaderboardPositionRow(
                team: solarTeamTwente,
                racePosition: solarTeamTwente.position,
              ),
              const SizedBox(height: Sizes.s12),
            ],
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final RaceTeam team = leaderboard[index];
                return LeaderboardPositionRow(
                  team: team,
                  racePosition: team.position,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
