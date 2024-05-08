part of 'profile_cubit.dart';

/// State for the profile feature.
sealed class ProfileState extends Equatable {
  /// Creates a new [ProfileState] instance.
  const ProfileState();
}

/// Initial state for the profile feature.
class ProfileInitialState extends ProfileState {
  /// Creates a [ProfileInitialState] instance.
  const ProfileInitialState();

  @override
  List<Object?> get props => <Object?>[];
}

/// State for when the profile is loading.
class ProfileLoadingState extends ProfileState {
  /// Creates a [ProfileLoadingState] instance.
  const ProfileLoadingState();

  @override
  List<Object?> get props => <Object?>[];
}

/// State for when the profile has been loaded.
class ProfileLoadedState extends ProfileState {
  /// Creates a [ProfileLoadedState] instance.
  const ProfileLoadedState(this.profile);

  /// The profile that has been loaded.
  final Profile profile;

  @override
  List<Object?> get props => <Object?>[profile];
}

/// State for when the profile has failed to load.
class ProfileErrorState extends ProfileState {
  /// Creates a [ProfileErrorState] instance.
  const ProfileErrorState({required this.code});

  /// The `ProfileExceptionCode` for this error state.
  final ProfileExceptionCode code;

  @override
  List<Object?> get props => <Object?>[code];
}
