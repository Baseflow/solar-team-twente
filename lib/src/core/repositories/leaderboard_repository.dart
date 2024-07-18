import '../entities/race/race_team.dart';

/// {@template leaderboard_repository}
/// Contract for the leaderboard repository.
/// {@endtemplate}
abstract class LeaderboardRepository {
  /// Returns a stream of the leaderboard.
  Stream<List<RaceTeam>> getLeaderboardStream();
}
