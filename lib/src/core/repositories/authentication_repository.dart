import 'package:supabase_flutter/supabase_flutter.dart';

import '../entities/auth/token.dart';

/// A repository to handle authenticating a user.
abstract interface class AuthenticationRepository {
  /// Signs in a user with their given [email] and [password].
  ///
  /// Returns a [Token] if the sign in was successful.
  /// Throws an exception if the sign in failed.
  Future<Token> signIn({required String email, required String password});

  /// Ends a users session.
  ///
  /// Ending the user's session will revoke the user's authentication and no
  /// longer allow access to any secure content.
  Future<void> endSession();

  /// Refreshes the current [token].
  ///
  /// Returns a new [Token] if the refresh was successful.
  /// Throws an exception if the refresh failed.
  Future<Token> refreshToken(Token token);

  /// Fetches the [Token] from local storage.
  Future<Token?> getToken();

  /// Registers a new account with their given [email] and [password].
  ///
  /// Returns a [Token] if the sign in was successful.
  /// Throws an exception if the sign in failed.
  Future<Token> registerAccount({required String email, required String password});

  /// Updates a password for a user with a [newPassword].
  ///
  /// Returns a [Token] if the update in was successful and stays logged in.
  /// Throws an exception if the update failed.
  Future<Token> updatePassword({required String newPassword});

  /// Resets the password for the user with the given [email].
  Future<void> resetPassword(String email);

  /// Deletes the account of the user if the [password] is correct.
  Future<void> deleteAccount({required String password});

  User? get currentUser;
}
