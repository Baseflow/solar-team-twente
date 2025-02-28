import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../assets/generated/assets.gen.dart';
import '../features/shared/widgets/state_message_view.dart';
import '../localizations/l10n.dart';

/// The page a user is navigated to when an error occurs during navigation.
///
/// For example, if a user tries to navigate to a page that does not exist,
/// this page will be displayed.
class NavigationErrorPage extends StatelessWidget {
  /// Creates a new [NavigationErrorPage] instance.
  const NavigationErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Whooops')),
      body: StateMessageView(
        asset: Lottie.asset(Assets.animations.notFound),
        message: context.l10n.notFoundErrorMessage,
      ),
    );
  }
}
