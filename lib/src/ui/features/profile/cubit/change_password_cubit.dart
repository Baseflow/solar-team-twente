import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'change_password_state.dart';

/// Cubit for managing the password change.
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  /// Creates a new instance of [ChangePasswordCubit].
  ChangePasswordCubit(
    this._authenticationService,
    ChangePasswordState initialChangePasswordState,
  ) : super(initialChangePasswordState);

  final AuthenticationService _authenticationService;

  /// Updates the [currentPassword] when the form changes.
  void updateCurrentPassword(String currentPassword) {
    emit(state.copyWith(currentPassword: currentPassword));
  }

  /// Updates the [newPassword] when the form changes.
  void updateNewPassword(String newPassword) {
    emit(state.copyWith(newPassword: newPassword));
  }

  /// Updates the [confirmNewPassword] when the form changes.
  void updateConfirmNewPassword(String confirmNewPassword) {
    emit(state.copyWith(confirmNewPassword: confirmNewPassword));
  }

  /// Changes password method.
  Future<void> changePassword() async {
    if (!state.validNewPassword) {
      emit(state.copyWith(changePasswordSuccessful: false));
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      await _authenticationService.updatePassword(
        newPassword: state.newPassword,
      );
      emit(state.copyWith(isLoading: false, changePasswordSuccessful: true));
    } on AuthenticationException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          changePasswordSuccessful: false,
          authErrorCode: e.errorCode,
        ),
      );
    }
  }
}
