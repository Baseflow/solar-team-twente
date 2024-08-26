import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/leaderboard_preview_cubit.dart';
import 'tabs/overall_ranking_tab.dart';

/// {@template leaderboard_view}
/// The view displaying the leaderboard.
/// {@endtemplate}
class LeaderboardView extends StatelessWidget {
  /// {@macro leaderboard_view}
  const LeaderboardView({this.tabIndex, super.key});

  final int? tabIndex;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ColoredBox(
      color: context.colorScheme.surface,
      child: DefaultTabController(
        length: 1, // 2 for the DailyRankingTab
        initialIndex: tabIndex ?? 0,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                Tab(text: l10n.overallRanking),
                //Tab(text: l10n.dailyRanking),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  BlocProvider<LeaderboardPreviewCubit>(
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
                              return const OverallRankingTab();
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
                  //  const DailyRankingTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
