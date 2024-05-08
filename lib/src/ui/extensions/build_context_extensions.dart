import 'dart:math';

import 'package:flutter/material.dart';

import '../themes/themes.dart';

/// Extensions on [BuildContext]
extension ContextExtension on BuildContext {
  /// Returns the [ThemeData] of the current [BuildContext].
  ThemeData get theme => Theme.of(this);

  /// Returns the [TextTheme] of the current [BuildContext].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns if the current [BuildContext] is in dark mode.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Returns a random [ColorScheme] for the current [BuildContext].
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  /// Returns the [ColorScheme] of the current [BuildContext].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the [AppThemeColorExtension]
  /// of the current [BuildContext].
  AppThemeColorExtension? get colorExtension =>
      Theme.of(this).extension<AppThemeColorExtension>();

  /// Shows the given [snackBar].
  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

/// Extensions on [BuildContext] for [MediaQueryData].
extension MediaQueryExtension on BuildContext {
  /// Returns if the keyboard is open for the current [BuildContext].
  bool get isKeyBoardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  /// Returns the [Brightness] of the current [BuildContext].
  Brightness get appBrightness => MediaQuery.platformBrightnessOf(this);

  /// Returns the height of the current [BuildContext].
  double get height => MediaQuery.sizeOf(this).height;

  /// Returns the width of the current [BuildContext].
  double get width => MediaQuery.sizeOf(this).width;

  /// Returns a dynamic height for the current [BuildContext].
  double dynamicWidth(double val) => width * val;

  /// Returns a dynamic width for the current [BuildContext].
  double dynamicHeight(double val) => height * val;
}
