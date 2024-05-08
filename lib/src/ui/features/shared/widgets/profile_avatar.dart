import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/cubit/profile_cubit.dart';

/// The avatar of the profile page.
class ProfileAvatar extends StatelessWidget {
  /// Creates a new instance of [ProfileAvatar].
  const ProfileAvatar({
    this.onTap,
    this.size = const Size(52, 52),
    super.key,
  });

  /// Creates a new instance of [ProfileAvatar] for a `small` avatar.
  const ProfileAvatar.small({
    this.onTap,
    this.size = const Size(32, 32),
    super.key,
  });

  /// The [size] of the avatar consisting of height and width.
  final Size size;

  /// The action to be executed if the widget is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, Uint8List?>(
      selector: (ProfileState state) {
        return state is ProfileLoadedState ? state.profile.profileImage : null;
      },
      builder: (BuildContext context, Uint8List? image) => GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: ColoredBox(
                color: Colors.grey,
                child: image == null
                    ? const Icon(Icons.person_outlined, color: Colors.white)
                    : Image.memory(image, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
