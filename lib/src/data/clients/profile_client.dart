import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/profile/profile_dto.dart';

part 'profile_client.g.dart';

/// Client for the Profile API.
@RestApi()
abstract class ProfileClient {
  /// Creates a new instance of the [ProfileClient].
  factory ProfileClient(Dio dio) = _ProfileClient;

  /// Gets a random User object.
  @GET('')
  Future<ProfileDTO> getRandomUser();
}
