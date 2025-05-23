import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/section.dart';
import '../cubit/theme_cubit.dart';

/// [ThemeSection] is the view to manage the theme settings.
class ThemeSection extends StatelessWidget {
  /// Creates a new instance of [ThemeSection].
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Section(title: l10n.appearance_settings, icon: Icons.dark_mode, children: const <Widget>[_ThemeRadioList()]);
  }
}

// Radio list to select the theme mode.
class _ThemeRadioList extends StatelessWidget {
  const _ThemeRadioList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (BuildContext context, AppThemeMode state) {
        return ListView(
          shrinkWrap: true,
          children: AppThemeMode.values.map<RadioListTile<AppThemeMode>>((AppThemeMode themeMode) {
            return RadioListTile<AppThemeMode>(
              title: Text(_getThemeTitle(themeMode, context)),
              value: themeMode,
              groupValue: state,
              onChanged: context.read<ThemeCubit>().updateTheme,
            );
          }).toList(),
        );
      },
    );
  }

  String _getThemeTitle(AppThemeMode themeMode, BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return switch (themeMode) {
      AppThemeMode.light => l10n.lightMode,
      AppThemeMode.dark => l10n.darkMode,
      AppThemeMode.system => l10n.systemMode,
    };
  }
}
