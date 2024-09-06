import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/admin_service.dart';

part 'admin_state.dart';

/// {@template admin_cubit}
/// The [AdminCubit] manages the state of the login form for admin.
/// {@endtemplate}
class AdminCubit extends Cubit<AdminState> {
  /// {@macro admin_cubit}
  AdminCubit(this._adminService) : super(const AdminState()) {
    _authStateSubscription =
        _adminService.authStateChanges.listen(_onAuthStateChanged);
  }

  final AdminService _adminService;

  late final StreamSubscription<AuthState> _authStateSubscription;

  /// Signs in the user.
  Future<void> signIn() async {
    emit(state.copyWith(isLoading: true));
    try {
      final User? user = await _adminService.signIn(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isLoading: false, user: user, loginSuccessful: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          loginSuccessful: false,
        ),
      );
    }
  }

  /// Signs out the user.
  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true, loginSuccessful: true));
    await _adminService.signOut();
    emit(state.copyWith(isLoading: false, loginSuccessful: false));
  }

  /// Updates the email.
  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  /// Updates the password.
  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void _onAuthStateChanged(AuthState authState) {
    if (authState.event == AuthChangeEvent.signedIn) {
      emit(
        state.copyWith(user: authState.session!.user, loginSuccessful: true),
      );
    } else if (authState.event == AuthChangeEvent.signedOut) {
      emit(state.copyWith(loginSuccessful: false));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
