import 'package:flutter/material.dart';

import 'settings_view.dart';

/// Creates the [SettingsView] and contains everything
/// related to navigating to the [SettingsPage].
class SettingsPage extends StatelessWidget {
  /// Creates a new instance of [SettingsPage].
  const SettingsPage({super.key});

  /// The path of the [SettingsView] route.
  static const String path = 'settings';

  /// The name of the [SettingsView] route.
  static const String name = 'Settings';

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}
