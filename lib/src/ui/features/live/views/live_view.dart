import 'package:flutter/material.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';

/// {@template live_view}
/// The UI for the live page, displaying the most important information
/// during the event, like the location of the vehicle, the speed,
/// battery level, etc.
/// {@endtemplate}
class LiveView extends StatelessWidget {
  /// {@macro live_view}
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            context.isDarkMode ? Assets.dark.logo.path : Assets.light.logo.path,
            fit: BoxFit.fitHeight,
            semanticLabel: 'Solarteam Twente Logo',
            height: 64,
          ),
        ),
        body: const Center(
          child: Text('Hier komt binnenkort een live map te staan.'),
        ),
      ),
    );
  }
}
