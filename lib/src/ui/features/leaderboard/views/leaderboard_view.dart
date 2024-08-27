import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../cubit/leaderboard_preview_cubit.dart';
import 'tabs/overall_ranking_tab.dart';

/// {@template leaderboard_view}
/// The view displaying the leaderboard.
/// {@endtemplate}
class LeaderboardView extends StatelessWidget {
  /// {@macro leaderboard_view}
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: BlocProvider<LeaderboardPreviewCubit>(
            create: (_) => LeaderboardPreviewCubit(
              LeaderboardService(
                leaderboardRepository:
                    Ioc.container.get<LeaderboardRepository>(),
              ),
            )..initializeLeaderboard(),
            child: Builder(
              builder: (BuildContext context) {
                return BlocBuilder<LeaderboardPreviewCubit,
                    LeaderboardPreviewState>(
                  builder: (
                    BuildContext context,
                    LeaderboardPreviewState state,
                  ) {
                    if (state is LeaderboardPreviewLoaded) {
                      return const OverallRankingView();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
