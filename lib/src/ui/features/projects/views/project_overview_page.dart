import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../localizations/l10n.dart';
import '../cubit/project_overview_cubit.dart';
import 'project_overview_view.dart';

/// Creates the [ProjectOverviewView] and contains everything related to
/// navigating to the [ProjectOverviewPage].
class ProjectOverviewPage extends StatelessWidget {
  /// Creates a new instance of the [ProjectOverviewPage] widget.
  const ProjectOverviewPage({super.key});

  /// The path of the [ProjectOverviewPage] route.
  static const String path = '/';

  /// The name of the [ProjectOverviewPage] route.
  static const String name = 'ProjectOverview';

  /// The destination for the [ProjectOverviewPage] route.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.projectOverviewPageTitle,
      selectedIcon: const Icon(Icons.home),
      icon: const Icon(Icons.home_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectOverviewCubit>(
      create: (_) => ProjectOverviewCubit(
        Ioc.container.get<ProjectService>(),
      )..getAllProjects(),
      child: const ProjectOverviewView(),
    );
  }
}
