import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/filled_loading_button.dart';
import '../cubit/forgot_password_cubit.dart';

final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

/// Form for resetting the password.
class ForgotPasswordView extends StatelessWidget {
  /// Creates a new instance of [ForgotPasswordView].
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SafeArea(
        child: Align(
          child: SizedBox(
            height: context.height,
            width: context.width > 600 ? 600 : context.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.s24),
                child: Column(
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Image.asset(
                        context.isDarkMode
                            ? Assets.dark.logo.path
                            : Assets.light.logo.path,
                        semanticLabel: context.l10n.appBarTitle,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const _ForgotPasswordForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatelessWidget {
  const _ForgotPasswordForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (
        ForgotPasswordState previous,
        ForgotPasswordState current,
      ) {
        final bool isEmailSentSuccessfully =
            previous.emailSentSuccessfully != current.emailSentSuccessfully &&
                current.emailSentSuccessfully;
        final bool isAuthError =
            previous.authErrorCode != current.authErrorCode &&
                current.authErrorCode != null;
        return isEmailSentSuccessfully || isAuthError;
      },
      listener: (BuildContext context, ForgotPasswordState state) {
        final String snackBarText = state.emailSentSuccessfully
            ? context.l10n.passwordChangeRequestSuccess
            : context.l10n.errorResettingPassword;
        context.showSnackBar(
          SnackBar(content: Text(snackBarText)),
        );
        if (state.emailSentSuccessfully) {
          context.pop();
        }
      },
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (BuildContext context, ForgotPasswordState state) {
          final ForgotPasswordCubit cubit = context.read<ForgotPasswordCubit>();
          return Form(
            key: _forgotPasswordFormKey,
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    onChanged: cubit.updateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const <String>[
                      AutofillHints.email,
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: context.l10n.email,
                    ),
                    validator: FormBuilderValidators.compose(
                      <FormFieldValidator<String>>[
                        FormBuilderValidators.required(
                          errorText: context.l10n.emailRequired,
                        ),
                        FormBuilderValidators.email(
                          errorText: context.l10n.emailInvalid,
                        ),
                      ],
                    ),
                    onFieldSubmitted: (_) {
                      if (!_forgotPasswordFormKey.currentState!.validate()) {
                        return;
                      }
                      cubit.sendPasswordResetEmail();
                    },
                  ),
                  const GutterLarge(),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (
                      BuildContext context,
                      ForgotPasswordState state,
                    ) {
                      return FilledLoadingButton(
                        buttonText: context.l10n.resetPassword,
                        onPressed: () {
                          if (_forgotPasswordFormKey.currentState!.validate()) {
                            cubit.sendPasswordResetEmail();
                          }
                        },
                        isLoading: state.isLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
