import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/theme_cubit.dart';

/// The view to manage the theme settings.
class ThemeView extends StatelessWidget {
  /// Creates a new instance of [ThemeView].
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (BuildContext context, AppThemeMode state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appearance_settings),
          ),
          body: ListView.builder(
            itemCount: AppThemeMode.values.length,
            itemBuilder: (BuildContext context, int index) {
              final AppThemeMode themeMode = AppThemeMode.values[index];
              return RadioListTile<AppThemeMode>(
                title: Text(_getThemeTitle(themeMode, context)),
                value: themeMode,
                groupValue: state,
                onChanged: (AppThemeMode? value) =>
                    context.read<ThemeCubit>().updateTheme(value),
              );
            },
          ),
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
