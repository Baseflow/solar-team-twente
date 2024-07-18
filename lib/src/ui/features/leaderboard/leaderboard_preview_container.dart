import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core.dart';
import '../../../assets/generated/assets.gen.dart';
import '../../constants/sizes_constants.dart';
import '../../extensions/build_context_extensions.dart';
import 'leaderboard_preview_cubit.dart';
import 'leaderboard_preview_list.dart';

/// {@template leaderboard_preview}
/// A short version of the leaderboard that is displayed on the dashboard.
/// {@endtemplate}
class LeaderboardPreviewContainer extends StatelessWidget {
  /// {@macro leaderboard_preview}
  const LeaderboardPreviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
              if (state is LeaderboardPreviewInitial ||
                  state is LeaderboardPreviewLoading) {
                return SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Shimmer.fromColors(
                    baseColor: context.colorScheme.secondary,
                    highlightColor: context.colorScheme.primary,
                    child: Image.asset(
                      Assets.light.logo.path,
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Tussenstand',
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: Sizes.s4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.s8),
                    child: Text(
                      'Afgelegde afstand',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(height: Sizes.s12),
                  const LeaderboardPreviewList(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
