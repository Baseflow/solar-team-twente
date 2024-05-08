import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/counter_cubit.dart';

/// A counter widget that allows users to increment a counter and displays the
/// count value on screen.
class CounterView extends StatelessWidget {
  /// Creates a new instance of the [CounterView] widget.
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterPageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(l10n.counterPageText),
            BlocBuilder<CounterCubit, int>(
              builder: (BuildContext context, int state) {
                return Text(
                  '$state',
                  style: context.textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('counterView_increment_fab'),
        heroTag: 'counter_fab',
        onPressed: context.read<CounterCubit>().increment,
        tooltip: l10n.counterIncrementTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
