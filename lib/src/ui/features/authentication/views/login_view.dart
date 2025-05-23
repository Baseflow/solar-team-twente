import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/build_context_extensions.dart';
import '../cubit/login_cubit.dart';
import '../widgets/change_language_button.dart';
import '../widgets/login_container.dart';

/// The view for signing in.
///
/// Because the LoginView is the first page to be shown after the app has
/// started, a PopScope is used to prevent the user from being able to go back.
/// This is necessary because of the way we setup go_router_builder.
class LoginView extends StatelessWidget {
  /// Creates a new instance of [LoginView].
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[Align(alignment: Alignment.centerRight, child: ChangeLanguageButton())],
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (LoginState previous, LoginState current) {
          return !current.isLoading && (current.authErrorCode != null || current.tokenErrorCode != null);
        },
        listener: (BuildContext context, LoginState state) {
          context.showSnackBar(SnackBar(content: Text(state.errorMessage)));
        },
        child: const SingleChildScrollView(child: LoginContainer()),
      ),
    );
  }
}
