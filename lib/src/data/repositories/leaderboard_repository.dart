import '../../../core.dart';

// TODO(anyone): replace with real implementation.
/// Implementations of the [LeaderboardRepository].
class MockLeaderboardRepository implements LeaderboardRepository {
  @override
  Stream<List<RaceTeam>> getLeaderboardStream() {
    return Stream<List<RaceTeam>>.value(
      List<RaceTeam>.generate(
        9,
        (int index) => RaceTeam(
          name: 'Team $index',
          totalDrivenKilometers: index * 100,
        ),
      )
        ..add(
          RaceTeam(name: Constants.solarTeamName, totalDrivenKilometers: 550),
        )
        ..sort(
          (RaceTeam a, RaceTeam b) => b.totalDrivenKilometers.compareTo(
            a.totalDrivenKilometers,
          ),
        ),
    );
  }
}
