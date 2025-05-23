import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// The [AdaptiveSplitLayout] shows a split layout on larger screens.
///
/// On smaller screens, the [body] is shown in full screen and the
/// [secondaryBody] is hidden. On larger screens, the [body] and [secondaryBody]
/// are shown side by side.
class AdaptiveSplitLayout extends StatelessWidget {
  /// Create a new instance of [AdaptiveSplitLayout]
  const AdaptiveSplitLayout({
    required this.body,
    this.secondaryBody,
    this.bodyRatio,
    super.key = const ValueKey<String>('ScaffoldWithNestedNavigation'),
  });

  /// The main body of the layout.
  final Widget body;

  /// The secondary body of the layout.
  final Widget? secondaryBody;

  /// The ratio of the body to the secondary body.
  final double? bodyRatio;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      bodyRatio: bodyRatio,
      transitionDuration: const Duration(milliseconds: 200),
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(key: const Key('Body Small'), builder: (_) => body),
          Breakpoints.mediumAndUp: SlotLayout.from(key: const Key('Body Medium'), builder: (_) => body),
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(key: const Key('Body Small')),
          Breakpoints.largeDesktop: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: secondaryBody != null ? (_) => secondaryBody! : AdaptiveScaffold.emptyBuilder,
          ),
        },
      ),
    );
  }
}
