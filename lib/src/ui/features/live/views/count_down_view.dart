import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

class CountDownView extends StatefulWidget {
  const CountDownView({super.key});

  @override
  State<CountDownView> createState() => _SolarRaceCountDownState();
}

class _SolarRaceCountDownState extends State<CountDownView> {
  late final StreamDuration streamDuration;
  static final DateTime _startDate = Constants.startDate;

  @override
  void initState() {
    streamDuration = StreamDuration(
      config: StreamDurationConfig(
        countDownConfig: CountDownConfig(
          duration: _startDate.difference(DateTime.now()),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    streamDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Expanded(child: SizedBox.shrink()),
        const Gutter(),
        RawSlideCountdown(
          streamDuration: streamDuration,
          builder: (
            BuildContext context,
            Duration duration,
            bool countUp,
          ) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CountDownItem(
                  label: 'dagen',
                  items: <RawDigitItem>[
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.days,
                      digitType: DigitType.first,
                      countUp: countUp,
                    ),
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.days,
                      digitType: DigitType.second,
                      countUp: countUp,
                    ),
                  ],
                ),
                const GutterSmall(),
                CountDownItem(
                  label: 'uren',
                  items: <RawDigitItem>[
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.hours,
                      digitType: DigitType.first,
                      countUp: countUp,
                    ),
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.hours,
                      digitType: DigitType.second,
                      countUp: countUp,
                    ),
                  ],
                ),
                const GutterSmall(),
                CountDownItem(
                  label: 'minuten',
                  items: <RawDigitItem>[
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.minutes,
                      digitType: DigitType.first,
                      countUp: countUp,
                    ),
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.minutes,
                      digitType: DigitType.second,
                      countUp: countUp,
                    ),
                  ],
                ),
                const GutterSmall(),
                CountDownItem(
                  label: 'secondes',
                  items: <RawDigitItem>[
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.seconds,
                      digitType: DigitType.first,
                      countUp: countUp,
                    ),
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.seconds,
                      digitType: DigitType.second,
                      countUp: countUp,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        const Gutter(),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: DottedLine(
              lineThickness: 3,
              dashLength: Sizes.s8,
              dashGapLength: Sizes.s8,
              dashColor: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class CountDownItem extends StatelessWidget {
  const CountDownItem({
    required this.items,
    required this.label,
    super.key,
  });

  final List<RawDigitItem> items;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const Icon(
              Icons.sunny,
              color: Colors.yellow,
              size: Sizes.s64,
            ),
            Row(children: items),
          ],
        ),
        const GutterSmall(),
        Text(
          label,
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
