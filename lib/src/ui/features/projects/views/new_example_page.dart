import 'package:flutter/material.dart';

import 'new_example_view.dart';

/// A [StatelessWidget] which is responsible for providing a
/// the [NewExampleView].
class NewExamplePage extends StatelessWidget {
  /// Creates a new instance of the [NewExamplePage] widget.
  const NewExamplePage({super.key});

  /// The path of the [NewExamplePage] route.
  static const String path = 'new-example';

  /// The name of the [NewExamplePage] route.
  static const String name = 'NewExample';

  @override
  Widget build(BuildContext context) {
    return const NewExampleView();
  }
}
