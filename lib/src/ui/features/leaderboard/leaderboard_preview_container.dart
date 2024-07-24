import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core.dart';
import '../../../assets/generated/assets.gen.dart';
import '../../extensions/build_context_extensions.dart';
import '../../localizations/generated/app_localizations.dart';
import '../../localizations/l10n.dart';
import 'cubit/leaderboard_preview_cubit.dart';
import 'leaderboard_preview_list.dart';

/// {@template leaderboard_preview}
/// A short version of the leaderboard that is displayed on the dashboard.
/// {@endtemplate}
class LeaderboardPreviewContainer extends StatelessWidget {
  /// {@macro leaderboard_preview}
  const LeaderboardPreviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocProvider<LeaderboardPreviewCubit>(
      create: (_) => LeaderboardPreviewCubit(
        LeaderboardService(
          leaderboardRepository: Ioc.container.get<LeaderboardRepository>(),
        ),
      )..initializeLeaderboard(),
      child: Builder(
        builder: (BuildContext context) {
          return BlocBuilder<LeaderboardPreviewCubit, LeaderboardPreviewState>(
            builder: (BuildContext context, LeaderboardPreviewState state) {
              return switch (state) {
                LeaderboardPreviewLoaded() => const LeaderboardPreviewList(),
                final LeaderboardPreviewEmpty _ => Text(
                    l10n.leaderboardEmptyMessage,
                    style: context.textTheme.bodyLarge,
                  ),
                final LeaderboardPreviewError _ => Text(
                    l10n.leaderboardErrorMessage,
                    style: context.textTheme.bodyLarge,
                  ),
                _ => SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: context.colorScheme.secondary,
                      highlightColor: context.colorScheme.primary,
                      child: Image.asset(
                        Assets.light.logo.path,
                        semanticLabel: 'Solarteam Twente Logo',
                      ),
                    ),
                  ),
              };
            },
          );
        },
      ),
    );
  }
}
