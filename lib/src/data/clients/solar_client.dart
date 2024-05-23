import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/leaderboard/leaderboard_entry_dto.dart';

part 'solar_client.g.dart';

/// Client for the Profile API.
@RestApi()
abstract class SolarClient {
  /// Creates a new instance of the [SolarClient].
  factory SolarClient(Dio dio) = _SolarClient;

  /// Gets a random User object.
  @GET('/leaderboard')
  Future<List<LeaderboardEntryDTO>> getLeaderboard();
}
