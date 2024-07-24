import '../entities/race/race_team.dart';
import '../repositories/leaderboard_repository.dart';

/// {@template leaderboard_service}
/// All leaderboard related business logic.
/// {@endtemplate}
class LeaderboardService {
  /// {@macro leaderboard_service}
  LeaderboardService({
    required LeaderboardRepository leaderboardRepository,
  }) : _leaderboardRepository = leaderboardRepository;

  final LeaderboardRepository _leaderboardRepository;

  /// Stream of the leaderboard, containing all teams and their driven
  /// kilometers.
  Stream<List<RaceTeam>> get leaderboard {
    return _leaderboardRepository.leaderboard;
  }
}
