import 'package:flutter/material.dart';

import 'language_view.dart';

/// The page displaying the language settings.
class LanguagePage extends StatelessWidget {
  /// Creates a new instance of [LanguagePage].
  const LanguagePage({super.key});

  /// The path of the [LanguagePage] route.
  static const String path = '/language';

  /// The name of the [LanguagePage] route.
  static const String name = 'Language';

  @override
  Widget build(BuildContext context) {
    return const LanguageView();
  }
}
