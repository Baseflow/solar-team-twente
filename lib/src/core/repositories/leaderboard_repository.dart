import '../entities/leaderboard/leaderboard_entry.dart';

/// Repository to fetch the leaderboard.
abstract class LeaderboardRepository {
  /// Gets the leaderboard of the race.
  Future<List<LeaderboardEntry>> getLeaderboard();
}
