part of 'authentication_cubit.dart';

/// The authentication state.
@immutable
class AuthenticationState extends Equatable {
  /// Creates a new [AuthenticationState] instance.
  const AuthenticationState({this.authStatus = AuthenticationStatus.initializing, this.token});

  /// The authentication status of the current user.
  final AuthenticationStatus authStatus;

  /// The current token.
  final Token? token;

  @override
  List<Object?> get props => <Object?>[authStatus, token];

  /// Creates a copy of the [AuthenticationState] with the supplied parameters
  /// replaced.
  AuthenticationState copyWith({AuthenticationStatus? authStatus, Token? token}) {
    return AuthenticationState(authStatus: authStatus ?? this.authStatus, token: token ?? this.token);
  }
}
