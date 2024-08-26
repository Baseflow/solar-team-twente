// import 'package:flutter/material.dart';
//
// import '../../../shared/widgets/action_chip_bar.dart';
//
// /// {@template daily_ranking_tab}
// /// The view displaying the daily ranking of the event.
// /// {@endtemplate}
// class DailyRankingTab extends StatelessWidget {
//   /// {@macro daily_ranking_tab}
//   const DailyRankingTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         ActionChipBar<int>(
//           values: List<int>.generate(8, (int index) => index),
//           selectedFilter: 0,
//           onChanged: (int index) {},
//           actionChipLabels: List<String>.generate(
//             8,
//             (int index) => 'Day ${index + 1}',
//           ),
//         ),
//         const Expanded(
//           child: Text(
//             'Implement daily ranking',
//           ),
//         ),
//       ],
//     );
//   }
// }
