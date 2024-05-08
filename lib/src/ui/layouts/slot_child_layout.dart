import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// A layout that adapts to different screen sizes.
///
/// This layout is to be used in overview pages where you would typically
/// have a list of items on mobile and an alternative layout on larger screens.
class SlotChildLayout extends StatelessWidget {
  /// Create a new instance of [SlotChildLayout]
  const SlotChildLayout({
    this.smallBody,
    this.mediumBody,
    this.largeBody,
    super.key,
  });

  /// The body to show on small screens.
  final Widget? smallBody;

  /// The body to show on medium screens and larger.
  final Widget? mediumBody;

  /// The body to show on large screens.
  ///
  /// Only apply this if you want to show a different body on large screens
  /// compared to medium and up screens.
  final Widget? largeBody;

  @override
  Widget build(BuildContext context) {
    return SlotLayout(
      config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: SlotLayout.from(
          key: const Key('adaptive_overview_layout_small_body'),
          builder: (_) => smallBody ?? AdaptiveScaffold.emptyBuilder(_),
        ),
        Breakpoints.medium: SlotLayout.from(
          key: const Key('adaptive_overview_layout_medium_body'),
          builder: (_) =>
              mediumBody ?? smallBody ?? AdaptiveScaffold.emptyBuilder(_),
        ),
        Breakpoints.large: SlotLayout.from(
          key: const Key('adaptive_overview_layout_large_body'),
          builder: (_) =>
              largeBody ??
              mediumBody ??
              smallBody ??
              AdaptiveScaffold.emptyBuilder(_),
        ),
      },
    );
  }
}
