import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template team_details_cubit}
/// Manages the index of the selected team member.
/// {@endtemplate}
class TeamDetailsCubit extends Cubit<int> {
  /// {@macro team_details_cubit}
  TeamDetailsCubit() : super(0);

  /// Selects the team member at the given index.
  void selectTeamMember(int index) {
    emit(index);
  }
}
