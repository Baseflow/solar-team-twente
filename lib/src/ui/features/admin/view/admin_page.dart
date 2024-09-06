import 'package:flutter/material.dart';

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
    return const AdminView();
  }
}
