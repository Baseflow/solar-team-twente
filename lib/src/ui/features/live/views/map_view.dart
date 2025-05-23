import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';
import 'map_loaded_view.dart';

/// {@template live_view}
/// The UI for the live page, displaying the most important information
/// during the event, like the location of the vehicle, the speed,
/// battery level, etc.
/// {@endtemplate}
class MapView extends StatelessWidget {
  /// {@macro live_view}
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (_, MapState state) {
        return switch (state) {
          final MapInitial _ || final MapLoading _ => const Center(child: CircularProgressIndicator()),
          final MapRaceLoaded _ => const MapLoadedView(),
        };
      },
    );
  }
}
