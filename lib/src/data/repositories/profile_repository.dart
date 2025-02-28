import 'package:dio/dio.dart';

import '../../../core.dart';
import '../clients/profile_client.dart';
import '../dto/profile/profile_dto.dart';

/// Concrete implementation of the [ProfileRepository] interface.
class ApiProfileRepository implements ProfileRepository {
  /// Creates a new [ApiProfileRepository] instance.
  const ApiProfileRepository(this._profileClient);
  final ProfileClient _profileClient;

  @override
  Future<Profile> getProfile() async {
    try {
      final ProfileDTO profileDTO = await _profileClient.getRandomUser();
      return profileDTO.toEntity();
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

  @override
  Future<void> resetPassword(String email) {
    return Future<void>.value();
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    return Future<void>.value();
  }
}
