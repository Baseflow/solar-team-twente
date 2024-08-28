import 'package:flutter/material.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

class TimeLineMarker extends StatelessWidget {
  const TimeLineMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s24,
      width: Sizes.s24,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colorScheme.primary,
          width: Sizes.s4,
        ),
      ),
    );
  }
}
