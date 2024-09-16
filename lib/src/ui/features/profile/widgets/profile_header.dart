import 'package:flutter/material.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';
import 'profile_header_painter.dart';

/// The header of the profile page.
class ProfileHeader extends StatelessWidget {
  /// Creates a new [ProfileHeader] instance.
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: ProfilePainter(context.colorScheme.primary),
          child: const SizedBox(
            height: 160,
            width: double.infinity,
          ),
        ),
        Positioned.fill(
          top: 16,
          child: CircleAvatar(
            radius: 64,
            backgroundColor: context.colorScheme.surface,
            child: CircleAvatar(
              radius: 60,
              child: ClipOval(
                child: SizedBox.square(
                  dimension: 100,
                  child: Image.asset(
                    context.theme.brightness == Brightness.dark
                        ? Assets.dark.logo.path
                        : Assets.light.logo.path,
                    semanticLabel: 'Logo Solarteam',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// TODO(anyone): Replace second CircleAvatar with below when profile is added.
// child: BlocSelector<ProfileCubit, ProfileState, Uint8List?>(
//   selector: (ProfileState state) {
//     if (state is ProfileLoadedState) {
//       return state.profile.profileImage;
//     }
//     return null;
//   },
//   builder: (BuildContext context, Uint8List? profileImg) {
//     return CircleAvatar(
//       radius: 60,
//       child: ClipOval(
//         child: SizedBox.square(
//           dimension: 100,
//           child: profileImg == null
//               ? Image.asset(
//                   context.theme.brightness == Brightness.dark
//                       ? Assets.dark.logo.path
//                       : Assets.light.logo.path,
//                 )
//               : Image.memory(
//                   profileImg,
//                   fit: BoxFit.cover,
//                 ),
//         ),
//       ),
//     );
//   },
// ),
