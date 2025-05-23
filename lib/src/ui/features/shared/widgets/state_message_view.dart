import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../constants/sizes_constants.dart';

/// The [StateMessageView] is a widget that displays a message and an asset.
///
/// This can be used to display a warning or error message.
class StateMessageView extends StatelessWidget {
  /// Creates a new instance of the [StateMessageView] widget.
  const StateMessageView({required this.asset, required this.message, super.key, this.child});

  /// The Lottie asset to display.
  ///
  /// This parameter should be used to display an image or animation that
  /// represents the message.
  ///
  /// This could for example be a Lottie animation:
  /// ```dart
  /// Lottie.asset('assets/animations/error.json');
  /// ```
  ///
  /// Or an image:
  /// ```dart
  /// Image.asset('assets/images/error.png');
  /// ```
  final Widget asset;

  /// The message to display.
  final String message;

  /// The child widget to display below the message.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            asset,
            const Gutter(),
            Text(message, textAlign: TextAlign.center),
            const Gutter(),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
