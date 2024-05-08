part of 'login_cubit.dart';

/// State to manage the login form.
class LoginState extends Equatable {
  /// Creates a new instance of [LoginState].
  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.authErrorCode,
    this.tokenErrorCode,
    this.loginSuccessful = false,
  });

  /// The email address.
  final String email;

  /// The password.
  final String password;

  /// Whether the form is currently submitting.
  final bool isLoading;

  /// The error code that has come back from the authentication repository in
  /// case of an error.
  final AuthenticationExceptionCode? authErrorCode;

  /// The error code that has come back from the token repository in case of an
  /// error.
  final TokenExceptionCode? tokenErrorCode;

  /// Whether the login was successful.
  final bool loginSuccessful;

  /// A user friendly error message based on the [authErrorCode] an
  /// [tokenErrorCode] fields.
  String get errorMessage {
    if (authErrorCode != null) {
      return authErrorCode!.toString();
    } else if (tokenErrorCode != null) {
      return tokenErrorCode!.toString();
    }

    return '';
  }

  /// Copy the state with new values.
  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    AuthenticationExceptionCode? authErrorCode,
    TokenExceptionCode? tokenErrorCode,
    bool? loginSuccessful,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      authErrorCode: authErrorCode ?? this.authErrorCode,
      tokenErrorCode: tokenErrorCode ?? this.tokenErrorCode,
      loginSuccessful: loginSuccessful ?? this.loginSuccessful,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        email,
        password,
        isLoading,
        authErrorCode,
        tokenErrorCode,
        loginSuccessful,
      ];
}
