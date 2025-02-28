import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core.dart';

part 'authentication_state.dart';

/// State manager responsible for authentication state.
class AuthenticationCubit extends Cubit<AuthenticationState> {
  /// Creates a new instance of [AuthenticationCubit].
  AuthenticationCubit(this._authenticationService)
      : _authStatusStream = _authenticationService.authStatusStream,
        _subscription = null,
        super(const AuthenticationState());

  final AuthenticationService _authenticationService;

  /// Stream of status changes provided by the [AuthenticationService].
  final Stream<AuthenticationStatus> _authStatusStream;

  /// Subscription to the [_authStatusStream] initialized in the
  /// [ensureValidToken] method.
  StreamSubscription<AuthenticationStatus>? _subscription;

  User? get currentUser => _authenticationService.currentUser;

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }

  /// Initializes the [AuthenticationCubit] by starting starting the token
  /// lifecycle in the [AuthenticationService].
  Future<void> ensureValidToken() async {
    _subscription = _authStatusStream.listen((AuthenticationStatus status) {
      emit(state.copyWith(authStatus: status));
    });
    await _authenticationService.ensureValidToken();
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await _authenticationService.logout();
  }
}
