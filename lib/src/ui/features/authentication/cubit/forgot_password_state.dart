part of 'forgot_password_cubit.dart';

/// Parent state for managing the forgot password form.
class ForgotPasswordState extends Equatable {
  /// Constructs a state with the shared email field.
  const ForgotPasswordState({
    this.email = '',
    this.authErrorCode,
    this.isLoading = false,
    this.emailSentSuccessfully = false,
  });

  /// Email that the user is requesting a password reset on.
  final String email;

  /// The error code that has come back from the authentication repository.
  final AuthenticationExceptionCode? authErrorCode;

  /// Whether the form is currently processing a submission.
  final bool isLoading;

  /// Whether the email was sent successfully.
  final bool emailSentSuccessfully;

  @override
  List<Object?> get props => <Object?>[
    email,
    authErrorCode,
    isLoading,
    emailSentSuccessfully,
  ];

  /// Copies the state with a new value.
  ForgotPasswordState copyWith({
    String? email,
    AuthenticationExceptionCode? authErrorCode,
    bool? isLoading,
    bool? emailSentSuccessfully,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      authErrorCode: authErrorCode ?? this.authErrorCode,
      isLoading: isLoading ?? this.isLoading,
      emailSentSuccessfully:
          emailSentSuccessfully ?? this.emailSentSuccessfully,
    );
  }
}
