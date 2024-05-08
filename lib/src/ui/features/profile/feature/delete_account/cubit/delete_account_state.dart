part of 'delete_account_cubit.dart';

/// The state for the delete account feature.
@immutable
sealed class DeleteAccountState extends Equatable {
  /// Creates a new [DeleteAccountState] instance.
  const DeleteAccountState({this.password});

  /// The password for the account.
  final String? password;

  /// Copy the state with new values.
  DeleteAccountState copyWith({
    String? password,
  });
}

/// The initial state for the delete account feature.
class DeleteAccountInitial extends DeleteAccountState {
  /// Creates a new [DeleteAccountInitial] instance.
  const DeleteAccountInitial({super.password});

  @override
  List<Object?> get props => <Object?>[password];

  @override
  DeleteAccountInitial copyWith({
    String? password,
  }) {
    return DeleteAccountInitial(
      password: password ?? this.password,
    );
  }
}

/// State for when the delete account feature is loading.
class DeleteAccountLoadingState extends DeleteAccountInitial {
  /// Creates a new [DeleteAccountLoadingState] instance.
  const DeleteAccountLoadingState({
    required super.password,
  });

  @override
  List<Object?> get props => <Object?>[password];
}

/// State for when the delete account feature has been successful.
class DeleteAccountSuccessState extends DeleteAccountInitial {
  /// Creates a new [DeleteAccountSuccessState] instance.
  const DeleteAccountSuccessState({
    required super.password,
  });

  @override
  List<Object> get props => <Object>[];
}

/// State for when the delete account feature has failed.
class DeleteAccountErrorState extends DeleteAccountInitial {
  /// Creates a new [DeleteAccountErrorState] instance.
  const DeleteAccountErrorState({
    required this.errorCode,
    required super.password,
  });

  /// The error code for this error state.
  final DeleteAccountExceptionCode errorCode;

  @override
  List<Object?> get props => <Object?>[errorCode, password];
}
