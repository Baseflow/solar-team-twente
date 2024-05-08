import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import '../../shared/widgets/base_list_tile.dart';
import '../../shared/widgets/filled_loading_button.dart';
import '../../shared/widgets/profile_avatar.dart';
import '../../shared/widgets/section.dart';
import '../cubit/profile_cubit.dart';
import '../feature/delete_account/views/delete_account_page.dart';
import '../widgets/image_picker_options.dart';
import 'change_password_page.dart';

/// The content of the `MyAccountView` page.
class ProfileContent extends StatelessWidget {
  /// Creates a new instance of `MyAccountContent`.
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        final bool hasProfile = state is ProfileLoadedState;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.s8),
          child: Column(
            children: <Widget>[
              Section(
                title: l10n.basicInfo,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      l10n.profilePicture,
                      style: context.textTheme.labelMedium,
                    ),
                    subtitle: Text(
                      l10n.profilePictureText,
                      style: context.textTheme.bodySmall,
                    ),
                    trailing: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ProfileAvatar(
                        onTap: () => showModalBottomSheet<void>(
                          context: context,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return const ImagePickerOptions();
                          },
                        ),
                      ),
                    ),
                  ),
                  BaseListTile(
                    title: l10n.name,
                    subtitle: hasProfile ? state.profile.name : l10n.unknown,
                    onTap: () {},
                  ),
                  BaseListTile(
                    title: l10n.dateOfBirth,
                    subtitle: '6th of June, 1999',
                    onTap: () {},
                  ),
                ],
              ),
              Section(
                title: l10n.contactInformation,
                children: <Widget>[
                  BaseListTile(
                    title: l10n.email,
                    subtitle: hasProfile ? state.profile.email : l10n.unknown,
                    onTap: () {},
                  ),
                  BaseListTile(
                    title: l10n.phoneNumber,
                    subtitle:
                        hasProfile ? state.profile.phoneNumber : l10n.unknown,
                    onTap: () {},
                  ),
                ],
              ),
              Section(
                title: l10n.address,
                children: <Widget>[
                  BaseListTile(
                    title: l10n.homeAddress,
                    subtitle: hasProfile ? state.profile.address : l10n.unknown,
                    onTap: () {},
                  ),
                ],
              ),
              Section(
                title: l10n.accountSettings,
                children: <Widget>[
                  BaseListTile(
                    title: l10n.changePassword,
                    onTap: () => context.goNamed(ChangePasswordPage.name),
                  ),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      l10n.deleteAccount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.error,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.goNamed(DeleteAccountPage.name),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.s16),
                child: FilledLoadingButton(
                  isLoading: false,
                  onPressed: () {
                    context.read<AuthenticationCubit>().signOut();
                  },
                  buttonText: l10n.signOut,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
