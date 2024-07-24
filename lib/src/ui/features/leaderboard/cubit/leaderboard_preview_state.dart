part of 'leaderboard_preview_cubit.dart';

/// The state of the leaderboard preview.
sealed class LeaderboardPreviewState extends Equatable {
  const LeaderboardPreviewState();
}

/// The initial state of the leaderboard preview.
final class LeaderboardPreviewInitial extends LeaderboardPreviewState {
  @override
  List<Object> get props => <Object>[];
}

/// The state of the leaderboard preview when it is loading.
final class LeaderboardPreviewLoading extends LeaderboardPreviewState {
  @override
  List<Object> get props => <Object>[];
}

/// {@template leaderboard_preview_loaded}
/// The state of the leaderboard preview when it is loaded.
/// {@endtemplate}
final class LeaderboardPreviewLoaded extends LeaderboardPreviewState {
  /// {@macro leaderboard_preview_loaded}
  const LeaderboardPreviewLoaded({required this.leaderboard});

  /// The stream of the leaderboard.
  final List<RaceTeam> leaderboard;

  /// The Solar Team Twente in the leaderboard.
  RaceTeam get solarTeamTwente => leaderboard.firstWhere(
        (RaceTeam team) => team.name == Constants.solarTeamName,
        orElse: () {
          return RaceTeam(
            name: 'Solar Team Twente not found',
            totalDrivenKilometers: -1,
            position: -1,
          );
        },
      );

  @override
  List<Object> get props => <Object>[leaderboard];
}

/// The state of the leaderboard preview when it has failed to load or is empty.
final class LeaderboardPreviewEmpty extends LeaderboardPreviewState {
  @override
  List<Object> get props => <Object>[];
}

/// The state of the leaderboard preview when an error occurs.
final class LeaderboardPreviewError extends LeaderboardPreviewState {
  @override
  List<Object> get props => <Object>[];
}
