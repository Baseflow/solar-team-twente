import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../authentication/cubit/login_cubit.dart';
import 'admin_view.dart';

/// {@template admin_page}
/// The [AdminPage] is the entry point to the admin view.
/// {@endtemplate}
class AdminPage extends StatelessWidget {
  /// {@macro admin_page}
  const AdminPage({super.key});

  /// The path for the admin view.
  static const String path = 'auth';

  /// The route name for the admin view.
  static const String routeName = 'Auth';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) =>
          LoginCubit(Ioc.container.get<AuthenticationService>()),
      child: const AdminView(),
    );
  }
}
