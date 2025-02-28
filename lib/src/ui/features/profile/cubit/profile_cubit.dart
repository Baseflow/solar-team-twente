import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core.dart';

part 'profile_state.dart';

/// Cubit for the profile feature.
class ProfileCubit extends Cubit<ProfileState> {
  /// Creates a [ProfileCubit].
  ProfileCubit(this._profileService) : super(const ProfileInitialState());

  final ProfileService _profileService;

  /// Gets the signed in users profile.
  Future<void> getProfile() async {
    emit(const ProfileLoadingState());
    try {
      final Profile profile = await _profileService.getProfile();
      emit(ProfileLoadedState(profile));
    } on ProfileException catch (e) {
      emit(ProfileErrorState(code: e.errorCode));
    } on Exception {
      emit(const ProfileErrorState(code: ProfileExceptionCode.unknown));
    }
  }

  /// Updates the profile image of the signed in user with
  /// the given [newImageAsBytes].
  Future<void> updateProfileImage(Uint8List newImageAsBytes) async {
    assert(
      state is ProfileLoadedState,
      'Profile must be loaded first before updating the profile image',
    );
    if (state is! ProfileLoadedState) return;

    try {
      final Profile profile = (state as ProfileLoadedState).profile;
      emit(const ProfileLoadingState());
      final Profile updatedProfile = profile.copyWith(
        profileImage: newImageAsBytes,
      );
      emit(ProfileLoadedState(updatedProfile));
    } on ProfileException catch (e) {
      emit(ProfileErrorState(code: e.errorCode));
    }
  }
}
