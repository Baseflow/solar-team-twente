import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../admin/view/admin_page.dart';
import '../../settings/views/settings_page.dart';
import '../../shared/widgets/custom_about_list_tile.dart';
import '../../team/team_details_page.dart';
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
    return Column(
      children: <Widget>[
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
          onTap: () => context.pushNamed(TermsAndConditionsPage.name),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: Text(l10n.privacyPolicy),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _launchPrivacyPolicyUrl(context),
        ),
        ListTile(
          leading: const Icon(Icons.groups),
          title: Text(l10n.aboutThisTeam),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.goNamed(TeamDetailsPage.routeName),
        ),
        ListTile(
          leading: const Icon(Icons.admin_panel_settings_rounded),
          title: Text(l10n.admin),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.goNamed(AdminPage.routeName),
        ),
        CustomAboutListTile(child: Text(l10n.about)),
      ],
    );

    // TODO(anyone): Replace the above code with the following code when the
    // TODO(anyone): profile feature is implemented.
    // return BlocBuilder<ProfileCubit, ProfileState>(
    //   builder: (BuildContext context, ProfileState state) {
    //     return switch (state) {
    //       ProfileLoadedState _ => Column(
    //           children: <Widget>[
    //             ListTile(
    //               leading: const Icon(Icons.person),
    //               title: Text(l10n.profileDetails),
    //               trailing: const Icon(Icons.chevron_right),
    //               onTap: () => context.goNamed(ProfilePage.name),
    //             ),
    //             ListTile(
    //               leading: const Icon(Icons.settings),
    //               title: Text(l10n.settings),
    //               trailing: const Icon(Icons.chevron_right),
    //               onTap: () => context.goNamed(SettingsPage.name),
    //             ),
    //             ListTile(
    //               leading: const Icon(Icons.shield),
    //               title: Text(l10n.termsAndConditions),
    //               trailing: const Icon(Icons.chevron_right),
    //               onTap: () => context.pushNamed(TermsAndConditionsPage.name),
    //             ),
    //             ListTile(
    //               leading: const Icon(Icons.privacy_tip),
    //               title: Text(l10n.privacyPolicy),
    //               trailing: const Icon(Icons.chevron_right),
    //               onTap: () => _launchPrivacyPolicyUrl(context),
    //             ),
    //             CustomAboutListTile(
    //               child: Text(l10n.about),
    //             ),
    //           ],
    //         ),
    //       ProfileErrorState _ => Center(
    //           child: Text(_getErrorText(state.code, l10n)),
    //         ),
    //       _ => const Center(child: CircularProgressIndicator()),
    //     };
    //   },
    // );
  }

  // Until profile is implemented, the following code is commented out.
  // String _getErrorText(ProfileExceptionCode code, AppLocalizations l10n) {
  //   return switch (code) {
  //     _ => l10n.profileNotFound,
  //   };
  // }

  Future<void> _launchPrivacyPolicyUrl(BuildContext context) async {
    final Uri url = Uri.parse(Constants.appPrivacyPolicy);
    final bool result = await launchUrl(url);
    if (result) return;
    if (!context.mounted) return;
    await context.showSnackBar(
      SnackBar(
        content: Text(context.l10n.couldNotLaunch),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
