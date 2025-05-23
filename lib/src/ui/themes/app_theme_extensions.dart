import 'package:flutter/material.dart';

import '../../../core.dart';

/// The application theme mode.
extension AppThemeModeExtension on AppThemeMode {
  /// Converts the application theme mode to the theme mode.
  ThemeMode toThemeMode() {
    return ThemeMode.values.firstWhere((ThemeMode element) => element.name == name, orElse: () => ThemeMode.system);
  }
}
