import '../entities/leaderboard/leaderboard_entry.dart';
import '../repositories/leaderboard_repository.dart';

/// Service for managing the leaderboard.
class LeaderboardService {
  /// Creates a new [LeaderboardService] instance.
  const LeaderboardService({
    required LeaderboardRepository leaderboardRepository,
  }) : _leaderboardRepository = leaderboardRepository;

  final LeaderboardRepository _leaderboardRepository;

  /// Gets the leaderboard entries.
  Future<List<LeaderboardEntry>> getLeaderboard() {
    return _leaderboardRepository.getLeaderboard();
  }
}
