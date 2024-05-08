import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../localizations/l10n.dart';
import 'more_view.dart';

/// Creates the [MorePage] and contains everything related to
/// navigating to the [MorePage].
class MorePage extends StatelessWidget {
  /// Creates a new instance of [MorePage].
  const MorePage({super.key});

  /// The path of the [MorePage] route.
  static const String path = '/more';

  /// The name of the [MorePage] route.
  static const String name = 'More';

  /// The destination for the [MorePage] route.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.more,
      selectedIcon: const Icon(Symbols.patient_list, fill: 1),
      icon: const Icon(Symbols.patient_list),
    );
  }

  @override
  Widget build(BuildContext context) => const MoreView();
}
