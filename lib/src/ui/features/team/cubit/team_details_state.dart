import 'package:equatable/equatable.dart';

class TeamDetailsState extends Equatable {
  const TeamDetailsState({this.currentIndex = 0});

  final int currentIndex;

  @override
  List<Object?> get props => <Object?>[
        currentIndex,
      ];
}
