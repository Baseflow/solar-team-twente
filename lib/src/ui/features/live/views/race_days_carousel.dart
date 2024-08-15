import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import 'count_down_view.dart';

class RaceDaysCarousel extends StatelessWidget {
  const RaceDaysCarousel({super.key});
  static DateTime startDate = Constants.startDate;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sizes.s16),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.s16),
              child: Row(
                children: <Widget>[
                  Text(
                    DateFormat.yMMMMd(
                      context.locale.toString(),
                    ).format(DateTime.now()),
                  ),
                  const Gutter(),
                  Text('Dag ${DateTime.now().difference(startDate).inDays}'),
                  Expanded(
                    child: Text(
                      '0 km afgelegd',
                      textAlign: TextAlign.end,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const GutterLarge(),
            SizedBox(
              height: 100,
              child: PageView(
                children: const <Widget>[
                  CountDownView(),
                  CountDownView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
