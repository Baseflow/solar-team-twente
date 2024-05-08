import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'project_overview_state.dart';

/// The [Cubit] manages the state of the project feature.
class ProjectOverviewCubit extends Cubit<ProjectOverviewState> {
  /// Creates a new [ProjectOverviewCubit] instance.
  ProjectOverviewCubit(this._projectService)
      : super(const ProjectOverviewInitialState());

  final ProjectService _projectService;

  /// Gets all the projects.
  Future<void> getAllProjects() async {
    emit(const ProjectOverviewLoadingState());
    try {
      final List<Project> projects = await _projectService.getAllProjects();

      if (projects.isEmpty) {
        return emit(const ProjectOverviewEmptyState());
      }

      emit(ProjectOverviewLoadedState(projects));
    } on ProjectException catch (e) {
      emit(ProjectOverviewErrorState(errorCode: e.errorCode));
    } on Exception {
      emit(
        const ProjectOverviewErrorState(
          errorCode: ProjectExceptionCode.unknown,
        ),
      );
    }
  }
}
