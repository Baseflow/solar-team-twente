import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:locale_names/locale_names.dart';

import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/base_list_tile.dart';
import '../cubit/language_cubit.dart';
import '../widgets/theme_section.dart';
import 'language_page.dart';

/// The view to manage settings like language and theme.
class SettingsView extends StatelessWidget {
  /// Creates a new instance of [SettingsView].
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlocBuilder<LanguageCubit, String>(
              builder: (BuildContext context, String languageCode) {
                return BaseListTile(
                  title: l10n.language,
                  subtitle:
                      context
                          .read<LanguageCubit>()
                          .currentLocale
                          .nativeDisplayLanguage,
                  leadingIcon: const Icon(Icons.language),
                  onTap: () => context.pushNamed(LanguagePage.name),
                );
              },
            ),
            const Divider(),
            const ThemeSection(),
          ],
        ),
      ),
    );
  }
}
