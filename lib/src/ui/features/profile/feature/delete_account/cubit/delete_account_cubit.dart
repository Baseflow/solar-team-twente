import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../../core.dart';

part 'delete_account_state.dart';

/// The [DeleteAccountCubit] manages the state of the delete account feature.
class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  /// Creates a new [DeleteAccountCubit] instance.
  DeleteAccountCubit(this._profileService)
    : super(const DeleteAccountInitial());

  final ProfileService _profileService;

  /// Update the password when the form changes.
  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  /// Deletes the account of the user if the password is correct.
  Future<void> deleteAccount() async {
    if (state.password == null) {
      emit(
        DeleteAccountErrorState(
          password: state.password,
          errorCode: DeleteAccountExceptionCode.passwordRequired,
        ),
      );
    }

    emit(DeleteAccountLoadingState(password: state.password));
    try {
      await _profileService.deleteAccount(password: state.password!);
      emit(DeleteAccountSuccessState(password: state.password));
    } on DeleteAccountException catch (e) {
      emit(
        DeleteAccountErrorState(
          password: state.password,
          errorCode: e.errorCode,
        ),
      );
    } on Exception {
      emit(
        DeleteAccountErrorState(
          password: state.password,
          errorCode: DeleteAccountExceptionCode.unknown,
        ),
      );
    }
  }
}
