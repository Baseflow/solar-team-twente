import 'package:flutter/material.dart';

import '../../../extensions/build_context_extensions.dart';

class TimeLineFilledLine extends StatelessWidget {
  const TimeLineFilledLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      color: context.colorScheme.primary,
    );
  }
}
