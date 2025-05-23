import 'package:flutter/material.dart';

import 'state_message_view.dart';

/// A widget that displays a message and an asset with a refresh indicator.
///
/// This can be used on pages where data is loaded into a view. Getting the data
/// might result in an error or the data might be empty. In these cases, the
/// [RefreshableStateMessage] can be used to display a message and an asset.
///
/// The user can pull down to refresh the data.
class RefreshableStateMessage extends StatelessWidget {
  /// Creates a new instance of the [RefreshableStateMessage] widget.
  const RefreshableStateMessage({
    required this.onRefresh,
    required this.asset,
    required this.message,
    super.key,
    this.child,
  });

  /// The callback to call when the refresh indicator is triggered.
  final RefreshCallback onRefresh;

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
  ///
  /// This could for example be a button to retry an operation or
  /// navigate to another page, to add a new item when used as an empty state.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: StateMessageView(asset: asset, message: message, child: child),
          ),
        ],
      ),
    );
  }
}
