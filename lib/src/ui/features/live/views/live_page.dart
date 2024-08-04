import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../localizations/l10n.dart';
import '../cubit/map_cubit.dart';
import 'live_view.dart';

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
    return BlocProvider<MapCubit>(
      create: (_) => MapCubit(
        Ioc.container.get<VehicleLocationService>(),
      )..started(),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: context.read<MapCubit>().onRefreshButtonPressed,
              ),
              backgroundColor: Colors.transparent,
            ),
            extendBodyBehindAppBar: true,
            body: const LiveView(),
          );
        },
      ),
    );
  }
}
