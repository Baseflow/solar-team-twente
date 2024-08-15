import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import 'time_line_dotted_line.dart';
import 'time_line_marker.dart';

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
    final AppLocalizations l10n = context.l10n;
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
                  label: l10n.day(2),
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
                  label: l10n.hour(2),
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
                  label: l10n.minute(2),
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
                  label: l10n.second(2),
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
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                TimeLineMarker(),
                Expanded(
                  child: TimeLineDottedLine(),
                ),
              ],
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
