import 'package:flutter/material.dart';

/// A collection of custom colors used in the app.
///
/// Often apps need more colors than the default [MaterialColor] provides.
/// For example a specific yellow used to display dutch license plates.
///
/// This color extension provides a way to add custom colors to the app.
///
/// They can be used like this:
/// ```dart
///  context.colorExtension?.licencePlateColor;
/// ```
@immutable
class AppThemeColorExtension extends ThemeExtension<AppThemeColorExtension> {
  /// Create a new instance of [AppThemeColorExtension]
  const AppThemeColorExtension();

  @override
  AppThemeColorExtension copyWith() {
    return const AppThemeColorExtension();
  }

  @override
  AppThemeColorExtension lerp(AppThemeColorExtension? other, double t) {
    if (other is! AppThemeColorExtension) {
      return this;
    }
    return const AppThemeColorExtension();
  }
}
