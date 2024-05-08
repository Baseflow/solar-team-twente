import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'register_state.dart';

/// Cubit for managing the registration page.
class RegisterCubit extends Cubit<RegisterState> {
  /// Creates a new instance of [RegisterCubit].
  RegisterCubit(this._authenticationService) : super(const RegisterState());

  final AuthenticationService _authenticationService;

  /// Update the email when the form changes.
  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  /// Update the password when the form changes.
  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  /// Update the confirm password when the form changes.
  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  /// Update the privacy and policy check.
  void updatePrivacyPolicyCheck({required bool isPrivacyPolicyAccepted}) {
    emit(state.copyWith(isPrivacyPolicyAccepted: isPrivacyPolicyAccepted));
  }

  /// Update the terms and conditions check.
  void updateTermsAndConditionsCheck({
    required bool isTermsAndConditionsAccepted,
  }) {
    emit(
      state.copyWith(
        isTermsAndConditionsAccepted: isTermsAndConditionsAccepted,
      ),
    );
  }

  /// Check if the passwords are matching.
  String? checkMatchingPasswords(String? errorText) {
    if (!state.passwordsMatch) {
      return errorText;
    }
    return null;
  }

  /// Register an account.
  Future<void> registerAccount() async {
    final String email = state.email;
    final String password = state.password;

    emit(
      state.copyWith(
        isPrivacyPolicyAccepted: true,
        isTermsAndConditionsAccepted: true,
      ),
    );

    if (state.isPrivacyPolicyAccepted &&
        state.isTermsAndConditionsAccepted &&
        state.passwordsMatch) {
      emit(state.copyWith(isLoading: true));
      await Future<void>.delayed(const Duration(seconds: 2));
      try {
        await _authenticationService.registerAccount(
          email: email,
          password: password,
        );
        emit(state.copyWith(isLoading: false, registerSuccessful: true));
      } on AuthenticationException catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            registerSuccessful: false,
            authErrorCode: e.errorCode,
          ),
        );
      }
    }
  }
}
