import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../core.dart';
import '../../../../../../assets/generated/assets.gen.dart';
import '../../../../../constants/sizes_constants.dart';
import '../../../../../extensions/build_context_extensions.dart';
import '../../../../../localizations/l10n.dart';
import '../../../../authentication/cubit/authentication_cubit.dart';
import '../../../../shared/widgets/filled_loading_button.dart';
import '../cubit/delete_account_cubit.dart';

/// The view that allows the user to delete their account.
class DeleteAccountView extends StatelessWidget {
  /// Creates a new instance of the [DeleteAccountView].
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.deleteAccount)),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(Sizes.s24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(Assets.animations.loadingFailed),
                    const Gutter(),
                    Text(
                      context.l10n.deleteAccountTitle,
                      style: context.textTheme.headlineSmall,
                    ),
                    const Gutter(),
                    Text(context.l10n.deleteAccountText),
                    const Gutter(),
                    Text(context.l10n.deleteAccountDataRemovalText),
                    _DeleteAccountForm(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final GlobalKey<FormState> _deleteAccountFormKey = GlobalKey<FormState>();

class _DeleteAccountForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (BuildContext context, DeleteAccountState state) {
        if (state is DeleteAccountSuccessState) {
          context.read<AuthenticationCubit>().signOut();
          context.showSnackBar(
            SnackBar(content: Text(context.l10n.deleteAccountSuccessMessage)),
          );
        }
      },
      builder: (BuildContext context, DeleteAccountState state) {
        return Form(
          key: _deleteAccountFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const GutterLarge(),
              TextFormField(
                scrollPadding: const EdgeInsets.only(bottom: Sizes.s128),
                onChanged: context.read<DeleteAccountCubit>().updatePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                textInputAction: TextInputAction.go,
                autofillHints: const <String>[AutofillHints.password],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: context.l10n.deleteAccountConfirmPassword,
                ),
                validator:
                    FormBuilderValidators.compose(<FormFieldValidator<String>>[
                      FormBuilderValidators.required(
                        errorText: context.l10n.deleteAccountPasswordRequired,
                      ),
                      (_) => _validatePassword(context),
                    ]),
              ),
              const Gutter(),
              FilledLoadingButton(
                key: const Key('delete_account_button'),
                isLoading: state is DeleteAccountLoadingState,
                buttonText: context.l10n.deleteAccount,
                onPressed: () {
                  if (_deleteAccountFormKey.currentState!.validate()) {
                    context.read<DeleteAccountCubit>().deleteAccount();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? _validatePassword(BuildContext context) {
    final DeleteAccountState state = context.read<DeleteAccountCubit>().state;
    if (state is! DeleteAccountErrorState) return null;
    return switch (state.errorCode) {
      DeleteAccountExceptionCode.invalidPassword =>
        context.l10n.deleteAccountInvalidPassword,
      DeleteAccountExceptionCode.unknown => context.l10n.unknownError,
      _ => null,
    };
  }
}
