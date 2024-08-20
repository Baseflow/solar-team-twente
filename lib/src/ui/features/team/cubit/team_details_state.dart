import 'package:equatable/equatable.dart';

/// {@template team_details_state}
/// The state of the team details page.
/// {@endtemplate}
class TeamDetailsState extends Equatable {
  /// {@macro team_details_state}
  const TeamDetailsState({this.currentIndex = 0});

  final int currentIndex;

  @override
  List<Object?> get props => <Object?>[
        currentIndex,
      ];
}
