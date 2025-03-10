import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/views/forgot_password_page.dart';
import '../features/authentication/views/login_page.dart';
import '../features/authentication/views/register_page.dart';

/// Stores the routes that are accessible to unauthenticated users.
class UnauthenticatedRoutes {
  /// The route for the login page.
  static GoRoute get value {
    return GoRoute(
      name: LoginPage.name,
      path: LoginPage.path,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const MaterialPage<void>(child: LoginPage());
      },
      routes: <RouteBase>[
        GoRoute(
          name: ForgotPasswordPage.name,
          path: ForgotPasswordPage.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage<void>(child: ForgotPasswordPage());
          },
        ),
        GoRoute(
          name: RegisterPage.name,
          path: RegisterPage.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage<void>(child: RegisterPage());
          },
        ),
      ],
    );
  }
}
