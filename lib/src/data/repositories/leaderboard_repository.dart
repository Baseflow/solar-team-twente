import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';
import '../dto/race/race_team_dto.dart';

/// {@template supabase_leaderboard_repository}
/// Supabase implementation of the [LeaderboardRepository].
/// {@endtemplate}
class SupabaseLeaderboardRepository implements LeaderboardRepository {
  /// {@macro supabase_leaderboard_repository}
  SupabaseLeaderboardRepository(this._client);

  final SupabaseClient _client;

  @override
  Stream<List<RaceTeam>> get leaderboard {
    final Stream<List<Map<String, dynamic>>> response = _client
        .from('leaderboard')
        .stream(primaryKey: <String>['id']).order('position', ascending: true);

    return response.map(
      (List<Map<String, dynamic>> data) => data.map<RaceTeam>(
        (Map<String, dynamic> json) {
          return RaceTeamDto.fromJson(json).toEntity();
        },
      ).toList(),
    );
  }
}
