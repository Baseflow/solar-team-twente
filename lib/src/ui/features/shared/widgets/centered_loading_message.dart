import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// A widget that displays a circular progress indicator and a message.
class CenteredLoadingMessage extends StatelessWidget {
  /// Creates a new instance of the [CenteredLoadingMessage] widget.
  CenteredLoadingMessage({
    required this.loadingMessage,
    super.key,
  }) : assert(loadingMessage.isNotEmpty, 'loadingMessage should not be empty');

  /// The message to display while loading.
  ///
  /// This message is displayed below the circular progress indicator and
  /// should not be empty.
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(),
          const Gutter(),
          Text(loadingMessage, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
