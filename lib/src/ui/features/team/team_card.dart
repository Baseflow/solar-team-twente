import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:go_router/go_router.dart';

import '../../../assets/generated/assets.gen.dart';
import '../../constants/sizes_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../localizations/l10n.dart';
import 'team_details_page.dart';

/// {@template team_card}
/// A card displaying the team.
///
/// When tapping the card, the user is navigated to the team details page.
/// {@endtemplate}
class TeamCard extends StatelessWidget {
  /// {@macro team_card}
  const TeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(image: AssetImage(Assets.solarTeamPeople.path), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Solarteam Twente 2024', style: context.textTheme.titleLarge),
                  const GutterTiny(),
                  Text('Sasol Solar Challenge - Innovation Edition', style: context.textTheme.bodySmall),
                  const Gutter(),
                  FilledButton(
                    onPressed: () {
                      context.goNamed(TeamDetailsPage.routeName);
                    },
                    child: Text(context.l10n.discoverTeamButtonText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
