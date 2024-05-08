import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/centered_loading_message.dart';
import '../../shared/widgets/refreshable_state_message.dart';
import '../cubit/project_overview_cubit.dart';
import '../widgets/project_card.dart';
import 'new_example_page.dart';

/// The [ProjectOverviewView] is the home page of the app.
class ProjectOverviewView extends StatelessWidget {
  /// Creates a new instance of the [ProjectOverviewView] widget.
  const ProjectOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ProjectOverviewCubit cubit = context.read<ProjectOverviewCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.projectOverviewPageTitle),
      ),
      body: BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
        builder: (BuildContext context, ProjectOverviewState state) {
          return switch (state) {
            ProjectOverviewLoadedState _ => _ProjectOverviewLoaded(
                state.projects,
              ),
            ProjectOverviewLoadingState _ => CenteredLoadingMessage(
                loadingMessage: context.l10n.projectOverviewLoading,
              ),
            ProjectOverviewEmptyState _ => RefreshableStateMessage(
                onRefresh: cubit.getAllProjects,
                asset: Lottie.asset(Assets.animations.emptyState),
                message: context.l10n.projectOverviewEmpty,
                child: ElevatedButton.icon(
                  onPressed: () => context.goNamed(NewExamplePage.name),
                  icon: const Icon(Icons.add),
                  label: Text(
                    context.l10n.projectOverviewAddProjectButtonText,
                  ),
                ),
              ),
            ProjectOverviewErrorState _ || _ => RefreshableStateMessage(
                onRefresh: cubit.getAllProjects,
                asset: Lottie.asset(Assets.animations.loadingFailed),
                message: context.l10n.projectOverviewLoadingError,
                child: ElevatedButton.icon(
                  onPressed: cubit.getAllProjects,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.tryAgainButtonText),
                ),
              ),
          };
        },
      ),
      floatingActionButton:
          BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
        builder: (BuildContext context, ProjectOverviewState state) {
          return switch (state) {
            ProjectOverviewLoadedState _ => FloatingActionButton(
                key: const Key('project_overview_fab'),
                // This tag is necessary if more than one fab is alive in the
                // state of the app.
                heroTag: 'project_overview_fab',
                onPressed: () => context.goNamed(NewExamplePage.name),
                child: Icon(Icons.add, semanticLabel: context.l10n.addAProject),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

/// The [ProjectOverviewView] is the home page of the app.
class _ProjectOverviewLoaded extends StatelessWidget {
  /// Creates a new instance of [_ProjectOverviewLoaded].
  const _ProjectOverviewLoaded(List<Project> projects) : _projects = projects;

  final List<Project> _projects;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<ProjectOverviewCubit>().getAllProjects,
      child: AnimatedGrid(
        padding: const EdgeInsets.all(Sizes.s16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Sizes.s512,
          childAspectRatio: 2,
          crossAxisSpacing: Sizes.s16,
          mainAxisSpacing: Sizes.s16,
        ),
        initialItemCount: _projects.length,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          final Project project = _projects[index];
          return ProjectCard(
            name: project.name,
            description: project.description,
          );
        },
      ),
    );
  }
}
