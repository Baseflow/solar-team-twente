import 'package:flutter/material.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';

/// The terms and conditions page.
class TermsAndConditionsView extends StatelessWidget {
  /// Creates a new [TermsAndConditionsView] instance.
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.termsAndConditions)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s16),
          child: RichText(
            text: TextSpan(text: context.l10n.termsAndConditionsText, style: context.textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }
}
