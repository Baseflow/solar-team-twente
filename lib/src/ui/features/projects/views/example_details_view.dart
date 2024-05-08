import 'package:flutter/material.dart';

import '../../../constants/sizes_constants.dart';

/// Example details view.
class ExampleDetailsView extends StatelessWidget {
  /// Creates a new instance of the [ExampleDetailsView] widget.
  const ExampleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Details'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(Sizes.s16),
          child: Text(
            'This page is just for showing how to navigate to a details page',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
