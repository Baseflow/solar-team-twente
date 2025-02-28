import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../localizations/l10n.dart';
import '../cubit/map_cubit.dart';
import '../cubit/race_day_carousel_cubit.dart';
import 'map_view.dart';
import 'race_days_bottom_sheet.dart';

/// {@template live_page}
/// Page to display the live data of the current Solarteam event, like the
/// location of the vehicle, the speed, battery level, etc.
/// {@endtemplate}
class LivePage extends StatelessWidget {
  /// {@macro live_page}
  const LivePage({super.key});

  /// The path of the dashboard page.
  static const String path = '/';

  /// The route name of the dashboard page.
  static const String routeName = 'LivePage';

  /// The destination for the [LivePage] route.
  ///
  /// This is necessary for the bottom navigation bar to display the correct
  /// icon and label for the page, as well as to navigate to the page.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.livePageTitle,
      selectedIcon: const Icon(Icons.sunny),
      icon: const Icon(Icons.sunny),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<Cubit<Object>>>[
        BlocProvider<RaceDayCarouselCubit>(
          create: (_) {
            final int daysSinceStart =
                DateTime.now().difference(Constants.startDate).inDays;
            return RaceDayCarouselCubit(
              selectedRaceDay:
                  Constants.hasRaceStarted
                      ? RaceDayType.values[daysSinceStart + 1]
                      : RaceDayType.prep,
              currentRaceDay:
                  Constants.hasRaceStarted
                      ? RaceDayType.values[daysSinceStart + 1]
                      : RaceDayType.prep,
            );
          },
        ),
        BlocProvider<MapCubit>(
          create:
              (_) =>
                  MapCubit(Ioc.container.get<VehicleLocationService>())
                    ..loadAssets(),
        ),
      ],
      child: const Stack(
        children: <Widget>[
          Positioned.fill(
            bottom:
                Sizes.carouselBottomSheetHeight -
                Sizes.defaultBottomSheetCornerRadius,
            child: MapView(),
          ),
          Positioned(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: SizedBox.shrink()),
                RaceDaysBottomSheet(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
