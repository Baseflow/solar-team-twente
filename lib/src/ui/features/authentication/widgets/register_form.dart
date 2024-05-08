import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/filled_loading_button.dart';
import '../cubit/register_cubit.dart';

final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

/// The form for the registration page.
class RegistrationForm extends StatelessWidget {
  /// Creates anew instance of the [RegistrationForm].
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final RegisterCubit cubit = context.read<RegisterCubit>();
    return Form(
      key: _registerFormKey,
      child: AutofillGroup(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: cubit.updateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const <String>[AutofillHints.email],
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                labelText: l10n.email,
              ),
              validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[
                  FormBuilderValidators.required(errorText: l10n.emailRequired),
                  FormBuilderValidators.email(errorText: l10n.emailInvalid),
                ],
              ),
            ),
            const Gutter(),
            TextFormField(
              onChanged: cubit.updatePassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              autofillHints: const <String>[AutofillHints.password],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: l10n.password,
              ),
              validator:
                  FormBuilderValidators.compose(<FormFieldValidator<String>>[
                FormBuilderValidators.required(
                  errorText: l10n.passwordRequired,
                ),
                FormBuilderValidators.minLength(
                  8,
                  errorText: l10n.passwordMinimum8Char,
                ),
                (_) => cubit.checkMatchingPasswords(l10n.passwordsNotMatching),
              ]),
            ),
            const Gutter(),
            TextFormField(
              onChanged: cubit.updateConfirmPassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              autofillHints: const <String>[AutofillHints.password],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: l10n.confirmPassword,
              ),
              validator:
                  FormBuilderValidators.compose(<FormFieldValidator<String>>[
                FormBuilderValidators.required(
                  errorText: l10n.passwordRequired,
                ),
                FormBuilderValidators.minLength(
                  8,
                  errorText: l10n.passwordMinimum8Char,
                ),
                (_) => cubit.checkMatchingPasswords(
                      l10n.passwordsNotMatching,
                    ),
              ]),
            ),
            const Gutter(),
            BlocConsumer<RegisterCubit, RegisterState>(
              listenWhen: (RegisterState previous, RegisterState current) =>
                  (previous.isLoading && !current.isLoading) &&
                  (current.authErrorCode != null),
              listener: (BuildContext context, RegisterState state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              },
              builder: (BuildContext context, RegisterState state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: '*${l10n.byRegisteringAnAccount} ',
                        style: context.textTheme.labelSmall,
                        children: <InlineSpan>[
                          TextSpan(
                            text: l10n.termsAndConditions.toLowerCase(),
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                final Uri url = Uri.parse(
                                  Constants.termsAndConditions,
                                );
                                launchUrl(url).catchError((Object error) {
                                  context.showSnackBar(
                                    SnackBar(
                                      content: Text(context.l10n.failLaunchUrl),
                                    ),
                                  );
                                  return false;
                                });
                              },
                          ),
                          TextSpan(text: ' ${l10n.and.toLowerCase()} '),
                          TextSpan(
                            text: l10n.privacyPolicy.toLowerCase(),
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                final Uri url =
                                    Uri.parse(Constants.appPrivacyPolicy);
                                launchUrl(url).catchError((Object error) {
                                  context.showSnackBar(
                                    SnackBar(
                                      content: Text(context.l10n.failLaunchUrl),
                                    ),
                                  );
                                  return false;
                                });
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const GutterLarge(),
                    FilledLoadingButton(
                      buttonText: l10n.register,
                      onPressed: () {
                        if (_registerFormKey.currentState!.validate()) {
                          cubit.registerAccount();
                        }
                      },
                      isLoading: state.isLoading,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
