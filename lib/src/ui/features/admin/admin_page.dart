import 'package:flutter/material.dart';

import 'admin_view.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  static const String path = 'auth';
  static const String routeName = 'Auth';

  @override
  Widget build(BuildContext context) {
    return const AuthView();
  }
}
