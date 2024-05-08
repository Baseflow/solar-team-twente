part of 'change_password_cubit.dart';

/// Parent state for managing the change password form.
class ChangePasswordState extends Equatable {
  /// Constructs a state with the shared email field.
  const ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.isLoading = false,
    this.authErrorCode,
    this.changePasswordSuccessful = false,
  });

  /// The current password.
  final String currentPassword;

  /// The new password.
  final String newPassword;

  /// The confirmed new password.
  final String confirmNewPassword;

  /// Whether the form is currently submitting.
  final bool isLoading;

  /// The error code that has come back from the authentication repository in
  /// case of an error.
  final AuthenticationExceptionCode? authErrorCode;

  /// Whether the change of password was successful.
  final bool changePasswordSuccessful;

  /// A user friendly error message based on the [authErrorCode] field.
  String get errorMessage => authErrorCode.toString();

  /// Whether the new passwords filled in by the user are the same.
  bool get newPasswordsMatch => newPassword == confirmNewPassword;

  /// Whether the new and current passwords are the same.
  bool get currentAndNewPasswordMatch => newPassword == currentPassword;

  /// Whether the new password is different than the old one.
  bool get validNewPassword => newPasswordsMatch && !currentAndNewPasswordMatch;

  @override
  List<Object?> get props => <Object?>[
    currentPassword,
    newPassword,
    confirmNewPassword,
    isLoading,
    authErrorCode,
    changePasswordSuccessful,
  ];

  /// Copies the state with a new value.
  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
    bool? isLoading,
    AuthenticationExceptionCode? authErrorCode,
    bool? changePasswordSuccessful,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      isLoading: isLoading ?? this.isLoading,
      authErrorCode: authErrorCode ?? this.authErrorCode,
      changePasswordSuccessful:
      changePasswordSuccessful ?? this.changePasswordSuccessful,
    );
  }
}
