import 'package:flutter/material.dart';

import '../../../assets/generated/assets.gen.dart';
import '../../localizations/generated/app_localizations.dart';
import '../../localizations/l10n.dart';

/// {@template team_details_view}
/// The view displaying the details of the team competing in this edition.
/// {@endtemplate}
class TeamDetailsView extends StatelessWidget {
  /// {@macro team_details_view}
  const TeamDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.teamPageTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              Assets.solarTeamPeople.path,
              semanticLabel: l10n.teamPhotoSemanticLabel,
            ),
          ],
        ),
      ),
    );
  }
}
