import 'package:flutter_bloc/flutter_bloc.dart';

import 'team_details_state.dart';

class TeamDetailsCubit extends Cubit<TeamDetailsState> {
  TeamDetailsCubit() : super(const TeamDetailsState());

  void selectTeamMember(int index) {
    emit(
      TeamDetailsState(currentIndex: index),
    );
  }
}
