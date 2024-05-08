import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/widgets/filled_loading_button.dart';
import '../cubit/change_password_cubit.dart';

final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();

/// The form used for changing a password when authenticated.
class ChangePasswordForm extends StatelessWidget {
  /// Creates a new instance of [ChangePasswordForm].
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ChangePasswordCubit cubit = context.read<ChangePasswordCubit>();
    return Form(
      key: _changePasswordFormKey,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: cubit.updateCurrentPassword,
              initialValue: AppConfig.defaultPassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              autofillHints: const <String>[AutofillHints.password],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                errorMaxLines: 2,
                prefixIcon: const Icon(Icons.lock),
                labelText: l10n.currentPassword,
              ),
              validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[
                  FormBuilderValidators.required(
                    errorText: l10n.passwordRequired,
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: l10n.passwordMinimum8Char,
                  ),
                      (_) => cubit.state.currentAndNewPasswordMatch
                      ? l10n.newPasswordShouldBeDifferent
                      : null,
                ],
              ),
            ),
            const Gutter(),
            TextFormField(
              onChanged: cubit.updateNewPassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              autofillHints: const <String>[AutofillHints.password],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                errorMaxLines: 2,
                prefixIcon: const Icon(Icons.lock),
                labelText: l10n.newPassword,
              ),
              validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[
                  FormBuilderValidators.required(
                    errorText: l10n.passwordRequired,
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: l10n.passwordMinimum8Char,
                  ),
                      (_) => !cubit.state.newPasswordsMatch
                      ? l10n.passwordsNotMatching
                      : null,
                ],
              ),
            ),
            const Gutter(),
            TextFormField(
              onChanged: cubit.updateConfirmNewPassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              autofillHints: const <String>[AutofillHints.password],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                errorMaxLines: 2,
                prefixIcon: const Icon(Icons.lock),
                labelText: l10n.confirmNewPassword,
              ),
              validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[
                  FormBuilderValidators.required(
                    errorText: l10n.passwordRequired,
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: l10n.passwordMinimum8Char,
                  ),
                      (_) => !cubit.state.newPasswordsMatch
                      ? l10n.passwordsNotMatching
                      : null,
                ],
              ),
            ),
            const GutterLarge(),
            BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listenWhen: (ChangePasswordState prev, ChangePasswordState curr) {
                final bool didLoadingStateChange =
                    prev.isLoading && !curr.isLoading;
                final bool hasError = curr.authErrorCode != null;
                final bool hasSuccess = curr.changePasswordSuccessful;
                return didLoadingStateChange && (hasError || hasSuccess);
              },
              listener: (BuildContext context, ChangePasswordState state) {
                if (state.authErrorCode != null) {
                  context.showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                } else if (state.changePasswordSuccessful) {
                  context.showSnackBar(
                    SnackBar(content: Text(l10n.changedPasswordSuccessfully)),
                  );
                }
              },
              builder: (BuildContext context, ChangePasswordState state) {
                return FilledLoadingButton(
                  buttonText: l10n.save,
                  onPressed: () {
                    if (!_changePasswordFormKey.currentState!.validate()) {
                      return;
                    }
                    cubit.changePassword().then((_) => context.pop());
                  },
                  isLoading: state.isLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
