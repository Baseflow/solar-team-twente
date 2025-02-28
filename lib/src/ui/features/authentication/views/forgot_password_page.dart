import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../cubit/forgot_password_cubit.dart';
import 'forgot_password_view.dart';

/// The forgot password page.
class ForgotPasswordPage extends StatelessWidget {
  /// Creates a new instance of [ForgotPasswordPage].
  const ForgotPasswordPage({super.key});

  /// Path for the page.
  static const String path = 'forgot-password';

  /// The route for the page.
  static const String name = 'ForgotPassword';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (BuildContext context) =>
          ForgotPasswordCubit(Ioc.container.get<AuthenticationService>()),
      child: const ForgotPasswordView(),
    );
  }
}
