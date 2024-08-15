import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../extensions/build_context_extensions.dart';

class TimeLineDottedLine extends StatelessWidget {
  const TimeLineDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      lineThickness: 3,
      alignment: WrapAlignment.spaceBetween,
      dashColor: context.colorScheme.primary,
    );
  }
}
