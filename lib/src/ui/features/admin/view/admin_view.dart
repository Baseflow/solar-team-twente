import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../localizations/l10n.dart';
import '../cubit/admin_cubit.dart';
import 'admin_container.dart';

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
      body: Center(
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (BuildContext context, AdminState state) {
            if (state.user != null) {
              return AdminLoggedIn(user: state.user!);
            } else {
              return const AdminContainer();
            }
          },
        ),
      ),
    );
  }
}

class AdminLoggedIn extends StatelessWidget {
  const AdminLoggedIn({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Signed in as: ${user.email}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<AdminCubit>().signOut();
              context.pop();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
