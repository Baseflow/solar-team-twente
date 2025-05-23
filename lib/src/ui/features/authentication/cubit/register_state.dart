part of 'register_cubit.dart';

/// State to manage the login form.
class RegisterState {
  /// Creates a new instance of [RegisterState].
  const RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.authErrorCode,
    this.registerSuccessful = false,
    this.isPrivacyPolicyAccepted = false,
    this.isTermsAndConditionsAccepted = false,
  });

  /// The email address.
  final String email;

  /// The password.
  final String password;

  /// The confirm password the user has to fill in.
  final String confirmPassword;

  /// Whether the form is currently submitting.
  final bool isLoading;

  /// The error code that has come back from the authentication repository in
  /// case of an error.
  final AuthenticationExceptionCode? authErrorCode;

  /// Whether the register was successful.
  final bool registerSuccessful;

  /// Whether the privacy policy is accepted.
  final bool isPrivacyPolicyAccepted;

  /// Whether the terms and conditions are accepted.
  final bool isTermsAndConditionsAccepted;

  /// A user friendly error message based on the [authErrorCode] field.
  String get errorMessage {
    if (authErrorCode != null) {
      return authErrorCode!.toString();
    }

    return '';
  }

  /// Whether the 2 passwords filled in by the user are the same.
  bool get passwordsMatch => password == confirmPassword;

  /// Copy the state with new values.
  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    AuthenticationExceptionCode? authErrorCode,
    bool? registerSuccessful,
    bool? isPrivacyPolicyAccepted,
    bool? isTermsAndConditionsAccepted,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      authErrorCode: authErrorCode ?? this.authErrorCode,
      registerSuccessful: registerSuccessful ?? this.registerSuccessful,
      isPrivacyPolicyAccepted: isPrivacyPolicyAccepted ?? this.isPrivacyPolicyAccepted,
      isTermsAndConditionsAccepted: isTermsAndConditionsAccepted ?? this.isTermsAndConditionsAccepted,
    );
  }
}
