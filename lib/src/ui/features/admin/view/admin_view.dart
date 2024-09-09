import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/l10n.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import '../../authentication/cubit/login_cubit.dart';
import 'admin_container.dart';
import 'admin_page.dart';

/// {@template admin_view}
/// The [AdminView] is the entry point to the admin view.
/// {@endtemplate}
class AdminView extends StatelessWidget {
  /// {@macro admin_view}
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = context.read<LoginCubit>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.admin),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (LoginState previous, LoginState current) {
          return !current.isLoading &&
              (current.authErrorCode != null || current.tokenErrorCode != null);
        },
        listener: (BuildContext context, LoginState state) {
          context.showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        },
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen:
              (AuthenticationState previous, AuthenticationState current) {
            return current.authStatus != previous.authStatus;
          },
          listener: (BuildContext context, AuthenticationState state) {
            if (state.authStatus == AuthenticationStatus.authenticated) {
              context.goNamed(AdminPage.routeName);
            }
          },
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              return Center(
                child: state.authStatus == AuthenticationStatus.authenticated
                    ? AdminLoggedIn(user: user)
                    : const AdminContainer(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AdminLoggedIn extends StatelessWidget {
  const AdminLoggedIn({required this.user, super.key});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Signed in as: ${user?.email}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationCubit>().signOut();
              context.pop();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
