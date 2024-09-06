import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';

/// {@template admin_service}
/// Takes care of all authentication related business logic.
/// {@endtemplate}
class AdminService {
  /// {@macro admin_service}
  AdminService({
    required AdminRepository adminRepository,
  }) : _adminRepository = adminRepository;

  final AdminRepository _adminRepository;

  /// Only emits [AuthState] changes.
  Stream<AuthState> get authStateChanges => _adminRepository.authStateChanges;

  /// The currently logged in user.
  User? get currentUser => _adminRepository.currentUser;

  /// Signs in the user with the given [email] and [password].
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    return _adminRepository.signIn(email: email, password: password);
  }

  /// Signs out the currently user.
  Future<void> signOut() async {
    await _adminRepository.signOut();
  }
}
