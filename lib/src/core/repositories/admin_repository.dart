import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template admin_repository}
/// Contract for the admin authentication repository.
/// {@endtemplate}
abstract interface class AdminRepository {
  /// Only emits [AuthState] changes.
  Stream<AuthState> get authStateChanges;

  /// Returns current registered user.
  User? get currentUser;

  /// Signs in the user with the given [email] and [password].
  Future<User?> signIn({required String email, required String password});

  /// Signs out the user.
  Future<void> signOut();
}
