import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../constants/sizes_constants.dart';

/// Reusable filled button that implements a loading state.
class FilledLoadingButton extends StatelessWidget {
  /// Creates an instance of the [FilledLoadingButton].
  const FilledLoadingButton({
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  /// The text displayed on the button.
  final String buttonText;

  /// The function that will be called when the button is pressed.
  final VoidCallback onPressed;

  /// Whether the state [isLoading].
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox.square(
                  dimension: Sizes.s24,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
                const GutterSmall(),
                Text(buttonText),
              ],
            )
          : Text(buttonText),
    );
  }
}
