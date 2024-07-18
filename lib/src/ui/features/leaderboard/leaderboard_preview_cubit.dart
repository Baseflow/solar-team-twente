import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';

part 'leaderboard_preview_state.dart';

/// {@template leaderboard_preview_cubit}
/// Manages the state of the leaderboard preview.
/// {@endtemplate}
class LeaderboardPreviewCubit extends Cubit<LeaderboardPreviewState> {
  /// {@macro leaderboard_preview_cubit}
  LeaderboardPreviewCubit(LeaderboardService leaderboardService)
      : _leaderboardService = leaderboardService,
        super(
          LeaderboardPreviewInitial(),
        );

  final LeaderboardService _leaderboardService;

  late StreamSubscription<List<RaceTeam>> _leaderboardSubscription;

  /// Subscribes to the stream of the leaderboard.
  Future<void> initializeLeaderboard() async {
    emit(LeaderboardPreviewLoading());
    await Future<void>.delayed(const Duration(seconds: 2));
    _leaderboardSubscription = _leaderboardService.leaderboardStream.listen(
      (List<RaceTeam> leaderboard) {
        if (leaderboard.isEmpty) {
          emit(LeaderboardPreviewEmpty());
        } else {
          emit(LeaderboardPreviewLoaded(leaderboard: leaderboard));
        }
      },
      onError: (Object error) {
        emit(LeaderboardPreviewError());
      },
    );
  }

  @override
  Future<void> close() {
    _leaderboardSubscription.cancel();
    return super.close();
  }
}
