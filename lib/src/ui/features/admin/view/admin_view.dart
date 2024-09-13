import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core.dart';
import '../../../localizations/l10n.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import 'admin_container.dart';
import 'admin_page.dart';
import 'authorized_admin_view.dart';

/// {@template admin_view}
/// The [AdminView] is the entry point to the admin view.
/// {@endtemplate}
class AdminView extends StatelessWidget {
  /// {@macro admin_view}
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.admin),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listenWhen:
            (AuthenticationState previous, AuthenticationState current) {
          return previous.authStatus != current.authStatus;
        },
        listener: (BuildContext context, AuthenticationState state) {
          if (state.authStatus == AuthenticationStatus.unauthenticated) {
            context.goNamed(AdminPage.routeName);
          }
        },
        builder: (BuildContext context, AuthenticationState state) {
          return switch (state.authStatus) {
            AuthenticationStatus.unauthenticated => const AdminContainer(),
            AuthenticationStatus.authenticated => AuthorizedAdminView(
                user: context.read<AuthenticationCubit>().currentUser,
              ),
            _ => const CircularProgressIndicator(),
          };
        },
      ),
    );
  }
}
