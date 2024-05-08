import '../entities/profile/profile.dart';

/// Interface for creating a data-layer implementation to manage user profiles.
abstract interface class ProfileRepository {
  /// Gets the signed in users [Profile].
  Future<Profile> getProfile();

  /// Resets the password for the user with the given [email].
  Future<void> resetPassword(String email);

  /// Deletes the account of the user if the [password] is correct.
  Future<void> deleteAccount({required String password});
}
