import 'package:flutter/material.dart';

import 'time_line_dotted_line.dart';
import 'time_line_filled_line.dart';
import 'time_line_marker.dart';

class RaceDayView extends StatelessWidget {
  const RaceDayView({
    this.showPreviousRace = true,
    this.showNextRace = true,
    this.showCurrentRace = true,
    this.isPreviousRaceDone = false,
    this.isCurrentRaceDone = false,
    this.isNextRaceDone = false,
    super.key,
  });

  final bool showPreviousRace;
  final bool showNextRace;
  final bool showCurrentRace;
  final bool isPreviousRaceDone;
  final bool isCurrentRaceDone;
  final bool isNextRaceDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (showPreviousRace)
          Flexible(child: isPreviousRaceDone ? const TimeLineFilledLine() : const TimeLineDottedLine())
        else
          const Flexible(child: SizedBox.expand()),
        const TimeLineMarker(),
        if (showCurrentRace) ...<Widget>[
          Expanded(flex: 8, child: isCurrentRaceDone ? const TimeLineFilledLine() : const TimeLineDottedLine()),
          const TimeLineMarker(),
        ] else
          const Expanded(flex: 8, child: SizedBox.expand()),
        if (showNextRace)
          Flexible(child: isNextRaceDone ? const TimeLineFilledLine() : const TimeLineDottedLine())
        else
          const Flexible(child: SizedBox.expand()),
      ],
    );
  }
}
