import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../widgets/register_form.dart';


/// The view for registering a new account.
class RegisterView extends StatelessWidget {
  /// Creates a new instance of [RegisterView].
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                    Assets.baseflowLogo.path,
                    semanticLabel: l10n.appBarTitle,
                    fit: BoxFit.contain,
                  ),
                ),
                const GutterLarge(),
                const RegistrationForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
