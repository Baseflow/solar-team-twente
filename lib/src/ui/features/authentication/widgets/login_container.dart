import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/filled_loading_button.dart';
import '../cubit/login_cubit.dart';
import '../views/forgot_password_page.dart';
import '../views/register_page.dart';

final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

/// The container displayed on the login page, containing the logo, login form
/// and sign in button.
class LoginContainer extends StatelessWidget {
  /// Creates a new instance of [LoginContainer].
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Sizes.s512),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.s24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FractionallySizedBox(
                  child: Image.asset(
                    context.isDarkMode
                        ? Assets.dark.logo.path
                        : Assets.light.logo.path,
                    semanticLabel: l10n.appBarTitle,
                    fit: BoxFit.contain,
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                ),
                const GutterLarge(),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (BuildContext context, LoginState state) {
                    return Form(
                      key: _loginFormKey,
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              onChanged: context.read<LoginCubit>().updateEmail,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofillHints: const <String>[
                                AutofillHints.email,
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                labelText: l10n.email,
                              ),
                              validator: FormBuilderValidators.compose(
                                <FormFieldValidator<String>>[
                                  FormBuilderValidators.required(
                                    errorText: l10n.emailRequired,
                                  ),
                                  FormBuilderValidators.email(
                                    errorText: l10n.emailInvalid,
                                  ),
                                ],
                              ),
                            ),
                            const Gutter(),
                            TextFormField(
                              onChanged:
                                  context.read<LoginCubit>().updatePassword,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              textInputAction: TextInputAction.go,
                              autofillHints: const <String>[
                                AutofillHints.password,
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                labelText: l10n.password,
                              ),
                              validator: FormBuilderValidators.required(
                                errorText: l10n.passwordRequired,
                              ),
                              onFieldSubmitted: (_) {
                                if (!_loginFormKey.currentState!.validate()) {
                                  return;
                                }
                                context.read<LoginCubit>().signIn();
                              },
                            ),
                            const Gutter(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  context.goNamed(ForgotPasswordPage.name);
                                },
                                child: Text(l10n.forgotPassword),
                              ),
                            ),
                            const Gutter(),
                            FilledLoadingButton(
                              isLoading: context.select<LoginCubit, bool>((
                                LoginCubit value,
                              ) {
                                return value.state.isLoading;
                              }),
                              onPressed: () {
                                if (!_loginFormKey.currentState!.validate()) {
                                  return;
                                }
                                context.read<LoginCubit>().signIn();
                              },
                              buttonText: l10n.signIn,
                            ),
                            const GutterSmall(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${l10n.noAccountYet}?',
                                    style: const TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Sizes.s4),
                                Flexible(
                                  child: TextButton(
                                    onPressed:
                                        () => context.pushNamed(
                                          RegisterPage.name,
                                        ),
                                    child: Text(
                                      '${l10n.register}.',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
