import 'package:flutter/material.dart';

import 'example_details_view.dart';

/// Example page to navigate to from one of the cards on the home page.
class ExampleDetailsPage extends StatelessWidget {
  /// Creates a new instance of [ExampleDetailsPage].
  const ExampleDetailsPage({super.key});

  /// The path of the [ExampleDetailsPage] route.
  static const String path = 'example-details';

  /// The name of the [ExampleDetailsPage] route.
  static const String name = 'ExampleDetails';

  @override
  Widget build(BuildContext context) {
    return const ExampleDetailsView();
  }
}
