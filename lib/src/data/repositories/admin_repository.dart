import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/repositories/admin_repository.dart';

/// {@template supabase_admin_repository}
/// Supabase implementation of the [AdminRepository].
/// {@endtemplate}
class SupabaseAdminRepository implements AdminRepository {
  /// {@macro supabase_admin_repository}
  const SupabaseAdminRepository(this._client);

  final SupabaseClient _client;

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final AuthResponse response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  User get currentUser => _client.auth.currentUser!;
}
