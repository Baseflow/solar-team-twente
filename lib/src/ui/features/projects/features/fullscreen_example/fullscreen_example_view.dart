import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The [FullScreenExampleView] is an example of how a full screen dialog page
/// can be implemented.
class FullScreenExampleView extends StatelessWidget {
  /// Creates a new instance of the [FullScreenExampleView] widget.
  const FullScreenExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Fullscreen example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This page is a fullScreenDialog'),
          ],
        ),
      ),
    );
  }
}
