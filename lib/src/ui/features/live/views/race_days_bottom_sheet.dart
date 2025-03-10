import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/race_day_carousel_cubit.dart';
import 'race_days_carousel.dart';

class RaceDaysBottomSheet extends StatelessWidget {
  const RaceDaysBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Container(
      height: Sizes.carouselBottomSheetHeight,
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: Sizes.s16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Sizes.defaultBottomSheetCornerRadius),
          topRight: Radius.circular(Sizes.defaultBottomSheetCornerRadius),
        ),
      ),
      child: BlocBuilder<RaceDayCarouselCubit, RaceDayCarouselState>(
        builder: (BuildContext context, RaceDayCarouselState state) {
          if (state is! RaceDayCarouselLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final DateTime dateToDisplay = state.selectedRaceDay.index == 0
              ? DateTime.now()
              : Constants.startDate.add(
                  Duration(days: state.selectedRaceDay.index - 1),
                );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.s16),
                child: Row(
                  children: <Widget>[
                    if (state.selectedRaceDay.index != 9)
                      Flexible(
                        child: Text(
                          DateFormat.yMMMMd(
                            context.locale.toString(),
                          ).format(dateToDisplay.toLocal()),
                        ),
                      ),
                    if (state.selectedRaceDay.index > 0) ...<Widget>[
                      if (state.selectedRaceDay.index != 9) ...<Widget>[
                        const GutterSmall(),
                        const Text('·'),
                        const GutterSmall(),
                        Text('${l10n.day(1)} ${state.selectedRaceDay.index}'),
                      ] else
                        Text(l10n.fullRace),
                    ],
                  ],
                ),
              ),
              const GutterLarge(),
              const RaceDaysCarousel(),
            ],
          );
        },
      ),
    );
  }
}
