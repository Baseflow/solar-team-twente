import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'leaderboard_preview_state.dart';

/// {@template leaderboard_preview_cubit}
/// Manages the state of the leaderboard preview.
/// {@endtemplate}
class LeaderboardPreviewCubit extends Cubit<LeaderboardPreviewState> {
  /// {@macro leaderboard_preview_cubit}
  LeaderboardPreviewCubit(LeaderboardService leaderboardService)
      : _leaderboardService = leaderboardService,
        super(LeaderboardPreviewInitial());

  final LeaderboardService _leaderboardService;

  late StreamSubscription<List<RaceTeam>>? _leaderboardSubscription;

  @override
  Future<void> close() {
    _leaderboardSubscription?.cancel();
    return super.close();
  }

  /// Subscribes to the stream of the leaderboard.
  Future<void> initializeLeaderboard() async {
    emit(LeaderboardPreviewLoading());

    _leaderboardSubscription = _leaderboardService.leaderboard.listen(
      (List<RaceTeam> leaderboard) {
        emit(
          leaderboard.isEmpty
              ? LeaderboardPreviewEmpty()
              : LeaderboardPreviewLoaded(leaderboard: leaderboard),
        );
      },
      onError: (dynamic error) {
        emit(LeaderboardPreviewError());
      },
    );
  }
}
