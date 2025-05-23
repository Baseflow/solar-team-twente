import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';

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
      child: Builder(
        builder: (BuildContext context) {
          final DateTime dateToDisplay = DateTime.now(); // TODO(triqoz): what date to display

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.s16),
            child: Row(
              children: <Widget>[
                Flexible(child: Text(DateFormat.yMMMMd(context.locale.toString()).format(dateToDisplay.toLocal()))),
                Text(l10n.fullRace),
              ],
            ),
          );
        },
      ),
    );
  }
}
