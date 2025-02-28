import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme_color_extension.dart';

/// Definition for the application's [ThemeData] implementations.
/// Specific colors can be overridden by Light and Dark themes.
class AppTheme {
  /// Creates a new instance of [AppTheme].
  AppTheme._init(FlexTones tones, {Brightness brightness = Brightness.light}) {
    theme = _createThemeData(tones, brightness);
    _setSystemBarsColor();
  }

  /// Creates a new instance of [AppTheme] with the light color scheme.
  factory AppTheme.light() =>
      AppTheme._init(FlexTones.material(Brightness.light));

  /// Creates a new instance of [AppTheme] with the dark color scheme.
  factory AppTheme.dark() => AppTheme._init(
    FlexTones.material(Brightness.dark),
    brightness: Brightness.dark,
  );

  /// Creates a new instance of [AppTheme] with the high contrast
  /// color scheme.
  factory AppTheme.highContrast() =>
      AppTheme._init(FlexTones.ultraContrast(Brightness.light));

  /// Creates a new instance of [AppTheme] with the high contrast dark
  /// color scheme.
  factory AppTheme.highContrastDark() => AppTheme._init(
    FlexTones.ultraContrast(Brightness.dark),
    brightness: Brightness.dark,
  );

  /// The base color of the application.
  final Color baseColorPrimary = const Color.fromRGBO(216, 64, 47, 1);

  /// Returns the theme.
  late final ThemeData theme;

  /// Creates a new [ThemeData] instance from [FlexTones] and [Brightness].
  ThemeData _createThemeData(FlexTones tones, Brightness brightness) {
    final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
      brightness: brightness,
      primaryKey: baseColorPrimary,
      primary: baseColorPrimary,
      tones: tones,
    );

    final ThemeData themeData = ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    );

    return themeData.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(
        themeData.textTheme,
      ).apply(bodyColor: colorScheme.onSurface),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: <AppThemeColorExtension>[const AppThemeColorExtension()],
      // Add custom theme properties here.
    );
  }

  /// Sets the color of the system bars.
  void _setSystemBarsColor() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
}
