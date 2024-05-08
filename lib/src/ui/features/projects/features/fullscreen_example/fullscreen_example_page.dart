import 'package:flutter/material.dart';

import 'fullscreen_example_view.dart';

/// A [StatelessWidget] which is responsible for providing a
/// the [FullScreenExampleView].
class FullScreenExamplePage extends StatelessWidget {
  /// Creates a new instance of the [FullScreenExamplePage] widget.
  const FullScreenExamplePage({super.key});

  /// Name of the [FullScreenExamplePage] route.
  static const String routeName = 'FullScreenExamplePage';

  @override
  Widget build(BuildContext context) {
    return const FullScreenExampleView();
  }
}
