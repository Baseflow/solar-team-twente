import 'package:flutter_bloc/flutter_bloc.dart';

import 'team_details_state.dart';

/// {@template team_details_cubit}
/// Manages the index of the selected team member.
/// {@endtemplate}
class TeamDetailsCubit extends Cubit<TeamDetailsState> {
  /// {@macro team_details_cubit}
  TeamDetailsCubit() : super(const TeamDetailsState());

  /// Selects the team member at the given index.
  void selectTeamMember(int index) {
    emit(
      TeamDetailsState(currentIndex: index),
    );
  }
}
