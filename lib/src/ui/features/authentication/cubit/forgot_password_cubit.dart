import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'forgot_password_state.dart';

/// Cubit for managing the forgot password page.
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  /// Creates a new instance of [ForgotPasswordCubit].
  ForgotPasswordCubit(this._profileService)
      : super(const ForgotPasswordState());

  final ProfileService _profileService;

  /// Update the email when the form field changes.
  void updateEmail(String email) => emit(state.copyWith(email: email));

  /// Sends a password reset email.
  Future<void> sendPasswordResetEmail() async {
    final String email = state.email;

    emit(state.copyWith(email: email, isLoading: true));
    try {
      await _profileService.resetPassword(email);
      emit(state.copyWith(isLoading: false, emailSentSuccessfully: true));
    } on AuthenticationException catch (e) {
      emit(
        state.copyWith(
          authErrorCode: e.errorCode,
          isLoading: false,
          emailSentSuccessfully: false,
        ),
      );
    }
  }
}
