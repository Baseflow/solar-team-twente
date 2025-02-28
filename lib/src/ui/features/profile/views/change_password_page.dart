import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../cubit/change_password_cubit.dart';
import 'change_password_view.dart';

/// The page for changing a password.
class ChangePasswordPage extends StatelessWidget {
  /// Creates a new instance of [ChangePasswordPage].
  const ChangePasswordPage({super.key});

  /// The path of the [ChangePasswordPage] route.
  static const String path = 'change-password';

  /// The name of the [ChangePasswordPage] route.
  static const String name = 'ChangePassword';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create:
          (BuildContext context) => ChangePasswordCubit(
            Ioc.container.get<AuthenticationService>(),
            const ChangePasswordState(),
          ),
      child: const ChangePasswordView(),
    );
  }
}
