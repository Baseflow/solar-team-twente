import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../profile/views/profile_page.dart';
import '../../settings/views/settings_page.dart';
import '../../shared/widgets/custom_about_list_tile.dart';
import '../views/terms_and_conditions_page.dart';

/// The options for a user displayed in the `MoreView`.
///
/// For example: `Profile details`, `Settings`, `Terms and Conditions`,
/// and `About`.
class MoreOptionsView extends StatelessWidget {
  /// Creates a new [MoreOptionsView] instance.
  const MoreOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        return switch (state) {
          ProfileLoadedState _ => Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(l10n.profileDetails),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.goNamed(ProfilePage.name),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(l10n.settings),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.goNamed(SettingsPage.name),
                ),
                ListTile(
                  leading: const Icon(Icons.shield),
                  title: Text(l10n.termsAndConditions),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.goNamed(TermsAndConditionsPage.name),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: Text(l10n.privacyPolicy),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _launchLink(context),
                ),
                CustomAboutListTile(
                  child: Text(l10n.about),
                ),
              ],
            ),
          ProfileErrorState _ => Center(
              child: Text(_getErrorText(state.code, l10n)),
            ),
          _ => const Center(child: CircularProgressIndicator()),
        };
      },
    );
  }

  String _getErrorText(ProfileExceptionCode code, AppLocalizations l10n) {
    return switch (code) {
      _ => l10n.profileNotFound,
    };
  }

  Future<void> _launchLink(BuildContext context) async {
    final Uri url = Uri.parse(Constants.appPrivacyPolicy);
    final bool result = await launchUrl(url);
    if (result) return;
    if (!context.mounted) return;
    context.showSnackBar(
      SnackBar(
        content: Text(context.l10n.couldNotLaunch),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
