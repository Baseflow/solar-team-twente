import 'package:flutter/material.dart';

import 'terms_and_conditions_view.dart';

/// The terms and conditions route.
class TermsAndConditionsPage extends StatelessWidget {
  /// Creates a new [TermsAndConditionsPage] instance.
  const TermsAndConditionsPage({super.key});

  /// The path of the [TermsAndConditionsPage] route.
  static const String path = '/terms-conditions';

  /// The route name of the [TermsAndConditionsPage] route.
  static const String name = 'TermsConditions';

  @override
  Widget build(BuildContext context) {
    return const TermsAndConditionsView();
  }
}
