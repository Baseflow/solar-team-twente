import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';
import '../../constants/sizes_constants.dart';
import '../../extensions/build_context_extensions.dart';
import 'leaderboard_preview_cubit.dart';

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
        return switch (state) {
          final LeaderboardPreviewLoaded l =>
            LeaderboardPreviewLoadedView(l.leaderboard),
          final LeaderboardPreviewEmpty _ => const Text(
              'No leaderboard available',
            ),
          final LeaderboardPreviewError _ => const Text(
              'Error loading leaderboard',
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

/// {@template leaderboard_preview_loaded_view}
/// The [leaderboard] listview that displays when data is loaded
/// and the list is not empty.
/// {@endtemplate}
@visibleForTesting
class LeaderboardPreviewLoadedView extends StatelessWidget {
  /// {@macro leaderboard_preview_loaded_view}
  const LeaderboardPreviewLoadedView(
    this.leaderboard, {
    super.key,
  });

  /// The leaderboard to display.
  final List<RaceTeam> leaderboard;

  @override
  Widget build(BuildContext context) {
    final int solarTeamIndex = leaderboard.indexWhere(
      (RaceTeam team) => team.name == Constants.solarTeamName,
    );
    final int solarTeamPosition = solarTeamIndex + 1;
    return Column(
      children: <Widget>[
        if (solarTeamPosition > 3) ...[
          LeaderboardPositionRow(
            team: leaderboard[solarTeamIndex],
            racePosition: solarTeamPosition,
          ),
          const SizedBox(height: Sizes.s12),
        ],
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final RaceTeam team = leaderboard[index];
            return LeaderboardPositionRow(
              team: team,
              racePosition: index + 1,
            );
          },
        ),
      ],
    );
  }
}

/// {@template leaderboard_position_row}
/// A row in the leaderboard that displays the position, team name, and
/// total driven kilometers.
/// {@endtemplate}
@visibleForTesting
class LeaderboardPositionRow extends StatelessWidget {
  /// {@macro leaderboard_position_row}
  const LeaderboardPositionRow({
    required this.team,
    required this.racePosition,
    super.key,
  });

  /// The team to display.
  final RaceTeam team;

  /// The position of the racing team on the leaderboard.
  final int racePosition;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.s8),
        color: team.name == Constants.solarTeamName
            ? context.colorScheme.primaryContainer
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.s12,
          vertical: Sizes.s8,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: Sizes.s16,
              child: Text(
                racePosition.toString(),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(team.name)),
            const SizedBox(width: 8),
            Text(
              '${team.totalDrivenKilometers} km',
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
