import 'package:flutter/material.dart';
import 'package:solar_team_twente/src/ui/localizations/generated/app_localizations.dart';

/// Widget for setting the locale with the material app.
///
/// With this the app can be tested with localizations.
class MaterialAppHelper extends StatelessWidget {
  /// Creates a new instance of the [MaterialAppHelper] widget.
  const MaterialAppHelper({required this.child, this.locale = 'en', super.key});

  /// The widget that is going to be tested.
  final Widget child;

  /// The locale to be used for testing, defaulted to english.
  final String locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Theme.of(context),
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            return Localizations.override(context: context, locale: Locale(locale), child: child);
          },
        ),
      ),
    );
  }
}
