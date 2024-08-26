import 'package:flutter/material.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

///{@template action_chip_bar}
/// The [ActionChip] widgets that are used for the days in the leaderboard.
/// {@endtemplate}
class ActionChipBar<T> extends StatelessWidget {
  ///{@macro action_chip_bar}
  const ActionChipBar({
    required this.onChanged,
    required this.actionChipLabels,
    required this.values,
    required this.selectedFilter,
    super.key,
  });

  /// The cubit function that is called, which passes the values
  /// of the generic T enum.
  final void Function(T) onChanged;

  /// Labels given to the ActionChips.
  final List<String> actionChipLabels;

  /// Enum values that the action chips pass to the onChanged function when
  /// they are pressed.
  final List<T> values;

  /// The current selected filter, which dictates the layout of the ActionChips.
  final T selectedFilter;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: Sizes.s8,
        children: List<Widget>.generate(
          actionChipLabels.length,
          (int index) {
            final bool isSelected = selectedFilter == values[index];
            return ActionChip(
              clipBehavior: Clip.antiAlias,
              side: isSelected
                  ? BorderSide(color: colorScheme.secondaryContainer)
                  : null,
              backgroundColor: isSelected
                  ? colorScheme.secondaryContainer
                  : colorScheme.onSecondary,
              label: Text(actionChipLabels[index]),
              avatar: isSelected
                  ? const Icon(Icons.check, color: Colors.black)
                  : null,
              onPressed: () => onChanged(values[index]),
            );
          },
        ),
      ),
    );
  }
}
