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
      appBar: AppBar(
        title: Text(l10n.termsAndConditions),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s16),
          child: RichText(
            text: TextSpan(
              text: 'This app, created by Baseflow, is provided "as is" and '
                  '"YourApp" (the Company) disclaims all warranties. By using '
                  'this app, you agree to these terms and conditions. The app '
                  'must not be used for illegal purposes. The Company may '
                  'modify or discontinue the app at any time. Continued use '
                  'signifies acceptance of changes. Review terms regularly. '
                  'The Company is not liable for any direct, indirect, '
                  'incidental, or consequential damages arising from your use '
                  'of the app.',
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
