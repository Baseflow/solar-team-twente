import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

/// A section as part of a larger list of sections that contains a title,
/// a divider and the section content.
class Section extends StatelessWidget {
  /// Creates a new [Section] instance.
  const Section({
    required this.title,
    required this.children,
    this.icon,
    super.key,
  });

  /// The title of the section.
  final String title;

  /// The children of the section.
  final List<Widget> children;

  /// Optional [icon] that can be passed as a leading widget to the title.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: Sizes.s16, top: Sizes.s16),
          child: Row(
            children: <Widget>[
              if(icon != null) ...<Widget>[
                Icon(icon),
                const Gutter(),
              ],
              Text(title, style: context.theme.textTheme.titleMedium),
            ],
          ),
        ),
        const Gutter(),
        ...children,
        const Divider(),
        const Gutter(),
      ],
    );
  }
}
