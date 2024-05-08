import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../localizations/l10n.dart';
import '../cubit/counter_cubit.dart';
import '../view/counter_view.dart';

/// Provides the [CounterCubit] and creates the [CounterView] and contains
/// everything related to navigating to the [CounterPage].
class CounterPage extends StatelessWidget {
  /// Creates a new instance of the [CounterPage] widget.
  const CounterPage({super.key});

  /// The path of the [CounterPage] route.
  static const String path = '/counter';

  /// The name of the [CounterPage] route.
  static const String name = 'Counter';

  /// The destination for the [CounterPage] route.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.counterPageTitle,
      selectedIcon: const Icon(Icons.add_circle),
      icon: const Icon(Icons.add_circle_outline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (BuildContext context) => CounterCubit(),
      child: const CounterView(),
    );
  }
}
