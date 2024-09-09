import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_scaffold_shell.dart';
import 'authenticated_routes.dart';
import 'navigation_error_page.dart';
import 'shared_routes.dart';
import 'unauthenticated_routes.dart';

/// The root navigator key for the main router of the app.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// The [GlobalRouter] maintains the main route configuration for the app.
///
/// Routes that are `fullScreenDialogs` should also set `_rootNavigatorKey` as
/// the `parentNavigatorKey` to ensure that the dialog is displayed correctly.
class GlobalRouter {
  /// The router with the routes of pages that should be displayed
  /// within the [AppScaffoldShell]
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      debugPrint('Error: ${state.error}');
      return const MaterialPage<void>(child: NavigationErrorPage());
    },
    // redirect: (BuildContext context, GoRouterState state) async {
    //   // Check if the route we want navigate to is a shared route, so we don't
    //   // need to check auth status.
    //   if (SharedRoutes.values.any(
    //     (GoRoute e) => state.fullPath?.contains(e.path) ?? false,
    //   )) {
    //     return null;
    //   }
    //
    //   final AuthenticationStatus authStatus =
    //       context.read<AuthenticationCubit>().state.authStatus;
    //
    //   // If the user is not logged in but still wants to go to a page that does
    //   // not need authentication, such as the forgot password page.
    //   if (authStatus == AuthenticationStatus.unauthenticated &&
    //       (state.fullPath?.contains(AdminPage.path) ?? false)) {
    //     return null;
    //   }
    //
    //   // If the user is not logged in, get kicked back to login page
    //   if (authStatus == AuthenticationStatus.unauthenticated) {
    //     return AdminPage.path;
    //   }
    //
    //   // If the user is successfully logged in but still on login, go to home.
    //   if (state.fullPath == LoginPage.path) {
    //     return LivePage.path;
    //   }
    //
    //   // In any other case the redirect can be safely ignored and handled as is.
    //   return null;
    // },
    routes: <RouteBase>[
      UnauthenticatedRoutes.value,
      AuthenticatedRoutes.value,
      ...SharedRoutes.values,
    ],
  );
}
