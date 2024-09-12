import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../authentication/cubit/authentication_cubit.dart';

/// {@template authorized_admin_view}
/// The [AuthorizedAdminView] is the entry point to the admin view.
/// {@endtemplate}
class AuthorizedAdminView extends StatelessWidget {
  /// {@macro authorized_admin_view}
  const AuthorizedAdminView({
    required this.user,
    super.key,
  });

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
            onPressed: context.read<AuthenticationCubit>().signOut,
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
