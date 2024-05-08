import 'package:flutter/material.dart';

/// The [NewExampleView] is an example of how a full screen dialog page
/// can be implemented.
class NewExampleView extends StatelessWidget {
  /// Creates a new instance of the [NewExampleView] widget.
  const NewExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fullscreen example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This page is a full screen modal page'),
          ],
        ),
      ),
    );
  }
}
