import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart' hide Breakpoints;
import 'package:go_router/go_router.dart';

import '../constants/sizes_constants.dart';
import '../extensions/build_context_extensions.dart';
import '../features/profile/cubit/profile_cubit.dart';
import '../features/profile/views/profile_page.dart';
import '../features/shared/widgets/profile_avatar.dart';
import '../layouts/slot_child_layout.dart';


/// The [TrailingNavigationRail] widget used in the AppScaffoldShell.
class TrailingNavigationRail extends StatelessWidget {
  /// Creates a new instance of the [TrailingNavigationRail].
  const TrailingNavigationRail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Divider(
            color: context.colorScheme.surfaceVariant,
            thickness: 1,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(Sizes.s32),
            onTap: () => context.goNamed(ProfilePage.name),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.s8),
              child: SlotChildLayout(
                mediumBody: ProfileAvatar.small(
                  onTap: () => context.goNamed(ProfilePage.name),
                ),
                largeBody: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (BuildContext context, ProfileState state) {
                    return Row(
                      children: <Widget>[
                        ProfileAvatar.small(
                          onTap: () => context.goNamed(ProfilePage.name),
                        ),
                        if (state is ProfileLoadedState) ...<Widget>[
                          const GutterTiny(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  state.profile.name,
                                  style: context.textTheme.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  state.profile.email,
                                  style: context.textTheme.labelSmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
