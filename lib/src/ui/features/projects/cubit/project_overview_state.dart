part of 'project_overview_cubit.dart';

/// The state for the project overview feature
sealed class ProjectOverviewState extends Equatable {
  /// Creates a new [ProjectOverviewState] instance.
  const ProjectOverviewState();
}

/// Initial state for the project overview feature.
class ProjectOverviewInitialState extends ProjectOverviewState {
  /// Creates a [ProjectOverviewInitialState] instance.
  const ProjectOverviewInitialState();

  @override
  List<Object> get props => <Object>[];
}

/// State for when the project overview is loading.
class ProjectOverviewLoadingState extends ProjectOverviewState {
  /// Creates a [ProjectOverviewLoadingState] instance.
  const ProjectOverviewLoadingState();

  @override
  List<Object> get props => <Object>[];
}

/// State for when the project overview has been loaded.
class ProjectOverviewLoadedState extends ProjectOverviewState {
  /// Creates a [ProjectOverviewLoadedState] instance.
  const ProjectOverviewLoadedState(this.projects);

  /// The list of projects that have been loaded.
  final List<Project> projects;

  @override
  List<Object> get props => <Object>[projects];
}

/// State for when the project overview is empty.
///
/// Should be emitted when the get request was successful but the list
/// of projects is empty.
class ProjectOverviewEmptyState extends ProjectOverviewState {
  /// Creates a [ProjectOverviewEmptyState] instance.
  const ProjectOverviewEmptyState();

  @override
  List<Object> get props => <Object>[];
}

/// State for when the project overview has failed to load.
class ProjectOverviewErrorState extends ProjectOverviewState {
  /// Creates a [ProjectOverviewErrorState] instance.
  const ProjectOverviewErrorState({required this.errorCode});

  /// The `ProjectExceptionCode` for this error state.
  final ProjectExceptionCode errorCode;

  @override
  List<Object> get props => <Object>[errorCode];
}
