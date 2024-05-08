import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../profile/widgets/profile_background.dart';
import '../../profile/widgets/profile_header.dart';
import '../widgets/more_options_view.dart';

/// The view displaying the user profile.
class MoreView extends StatelessWidget {
  /// Creates a new [MoreView] instance.
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Stack(
      children: <Widget>[
        const ProfileBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: context.colorScheme.primary,
            title: BlocSelector<ProfileCubit, ProfileState, String?>(
              selector: (ProfileState state) {
                return state is ProfileLoadedState ? state.profile.name : null;
              },
              builder: (BuildContext context, String? name) {
                return Text(
                  name ?? l10n.profilePageTitle,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                );
              },
            ),
          ),
          body:  const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ProfileHeader(),
                MoreOptionsView(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
