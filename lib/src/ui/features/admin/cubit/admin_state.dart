part of 'admin_cubit.dart';

/// {@template admin_state}
/// State to manage the login form for admin.
/// {@endtemplate}
class AdminState extends Equatable {
  /// {@macro admin_state}
  const AdminState({
    this.email = '',
    this.password = '',
    this.user,
    this.isLoading = false,
    this.loginSuccessful = false,
  });

  /// The email address.
  final String email;

  /// The password.
  final String password;

  /// The user object if the login was successful.
  final User? user;

  /// Whether the form is currently submitting.
  final bool isLoading;

  /// Whether the login was successful.
  final bool loginSuccessful;

  /// Copy the state with new values.
  AdminState copyWith({
    String? email,
    String? password,
    User? user,
    bool? isLoading,
    bool? loginSuccessful,
  }) {
    return AdminState(
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      loginSuccessful: loginSuccessful ?? this.loginSuccessful,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        email,
        password,
        user,
        isLoading,
        loginSuccessful,
      ];
}
