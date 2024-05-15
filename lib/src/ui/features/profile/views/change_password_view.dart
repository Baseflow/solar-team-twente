import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../widgets/change_password_form.dart';

/// The view provided for `ChangePasswordPage`.
class ChangePasswordView extends StatelessWidget {
  /// Creates a new instance of [ChangePasswordView].
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Sizes.s32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Sizes.s384,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Image.asset(
                      context.theme.brightness == Brightness.dark
                          ? Assets.dark.logo.path
                          : Assets.light.logo.path,
                      semanticLabel: l10n.appBarTitle,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const GutterLarge(),
                  const ChangePasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
