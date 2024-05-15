import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/l10n.dart';
import '../cubits/about_cubit.dart';

/// A custom about list tile that uses the [AboutCubit] to display the app name
/// and version.
class CustomAboutListTile extends StatelessWidget {
  /// Creates a new instance of [CustomAboutListTile].
  const CustomAboutListTile({required this.child, super.key});

  /// The child to display.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutCubit>(
      create: (BuildContext context) => AboutCubit()..fetchAppDetails(),
      child: BlocBuilder<AboutCubit, AboutState>(
        builder: (BuildContext context, AboutState state) {
          return AboutListTile(
            icon: const Icon(Icons.info),
            applicationName: state.appName,
            applicationVersion: state.appVersion,
            applicationLegalese: Constants.applicationLegalese,
            applicationIcon: Image.asset(
              context.isDarkMode
                  ? Assets.dark.logo.path
                  : Assets.light.logo.path,
              fit: BoxFit.contain,
              height: Sizes.s24,
            ),
            aboutBoxChildren: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: Sizes.s24),
                child: FilledButton.tonalIcon(
                  icon: const Icon(Icons.open_in_new),
                  label: Text(context.l10n.ourWebsite),
                  onPressed: () {
                    final Uri url = Uri.parse(Constants.appWebsite);
                    launchUrl(url).catchError((Object error) {
                      context.showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.failLaunchUrl),
                        ),
                      );
                      return false;
                    });
                  },
                ),
              ),
            ],
            child: child,
          );
        },
      ),
    );
  }
}
