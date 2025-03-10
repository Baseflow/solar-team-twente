import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localizations/l10n.dart';
import 'cubit/team_details_cubit.dart';
import 'team_details_view.dart';

/// {@template team_details_page}
/// The page displaying the details of the team competing in this edition.
/// {@endtemplate}
class TeamDetailsPage extends StatelessWidget {
  /// {@macro team_details_page}
  const TeamDetailsPage({super.key});

  /// The path of the dashboard page.
  static const String path = 'team';

  /// The route name of the dashboard page.
  static const String routeName = 'TeamPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeamDetailsCubit>(
      create: (_) => TeamDetailsCubit(),
      child: TeamDetailsView(l10n: context.l10n),
    );
  }
}
