import '../entities/profile/profile.dart';
import '../repositories/profile_repository.dart';

/// Service for managing user profiles.
class ProfileService {
  /// Creates a new [ProfileService] instance.
  const ProfileService({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  /// Gets the signed in users [Profile].
  Future<Profile> getProfile() {
    return _profileRepository.getProfile();
  }

  /// Starts the rest password procedure for the given [email].
  Future<void> resetPassword(String email) {
    return _profileRepository.resetPassword(email);
  }

  /// Deletes the account of the user if the [password] is correct.
  Future<void> deleteAccount({required String password}) async {
    return _profileRepository.deleteAccount(password: password);
  }
}
