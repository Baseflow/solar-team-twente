import 'package:dio/dio.dart';

import '../../../core.dart';
import '../clients/solar_client.dart';
import '../dto/leaderboard/leaderboard_entry_dto.dart';

/// Implementation of the [LeaderboardRepository] interface that uses the API.
class ApiLeaderboardRepository implements LeaderboardRepository {
  /// Creates a new [ApiLeaderboardRepository] instance.
  const ApiLeaderboardRepository(this._solarClient);

  /// The [SolarClient] instance to use.
  final SolarClient _solarClient;

  @override
  Future<List<LeaderboardEntry>> getLeaderboard() async {
    try {
      final List<LeaderboardEntryDTO> leaderboardEntryDTOs =
          await _solarClient.getLeaderboard();
      return leaderboardEntryDTOs
          .map((LeaderboardEntryDTO e) => e.toEntity())
          .toList();
    } catch (e) {
      if (e is DioException) {
        throw switch (e.response?.statusCode.toDataResponseCode()) {
          _ => UnknownException(
              e.message ?? 'Unhandled code ${e.response?.statusCode}',
            ),
        };
      }
      throw const UnknownException('Non dio exception');
    }
  }
}
