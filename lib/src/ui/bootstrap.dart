import 'package:flutter/widgets.dart';

import 'app/app.dart';

/// Initializes the UI library ensuring all dependencies are
/// registered.
///
/// The `bootstrap()` method is called from the `main.dart` file to
/// initialize the application.
Future<void> bootstrap() async {
  runApp(const App());
}
