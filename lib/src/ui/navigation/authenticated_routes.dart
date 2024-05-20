import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/more/views/more_page.dart';
import '../features/settings/views/settings_page.dart';
import 'app_scaffold_shell.dart';
import 'global_router.dart' as router show rootNavigatorKey;

    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _moreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'more');

/// Stores the routes that are accessible to authenticated users.
class AuthenticatedRoutes {
  /// The routes for the authenticated user.
  static StatefulShellRoute get value {
    return StatefulShellRoute.indexedStack(
      parentNavigatorKey: router.rootNavigatorKey,
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return AppScaffoldShell(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              pageBuilder: (BuildContext context, GoRouterState state) {
              },
            ),
          ],
        ),
          routes: <RouteBase>[
            GoRoute(
              pageBuilder: (BuildContext context, GoRouterState state) {
              },
            ),
          ],
        ),
      ],
    );
  }

  static StatefulShellBranch get _morePageRoutes {
    return StatefulShellBranch(
      navigatorKey: _moreNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
          name: MorePage.name,
          path: MorePage.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage<void>(
              key: ValueKey<String>(MorePage.name),
              child: MorePage(),
            );
          },
          routes: <RouteBase>[
            // TODO(anyone): add profile routes when profile is implemented.
            // GoRoute(
            //   path: ProfilePage.path,
            //   name: ProfilePage.name,
            //   pageBuilder: (BuildContext context, GoRouterState state) {
            //     return const MaterialPage<void>(child: ProfilePage());
            //   },
            //   routes: <RouteBase>[
            //     GoRoute(
            //       path: ChangePasswordPage.path,
            //       name: ChangePasswordPage.name,
            //       parentNavigatorKey: router.rootNavigatorKey,
            //       pageBuilder: (BuildContext context, GoRouterState state) {
            //         return const MaterialPage<void>(
            //           fullscreenDialog: true,
            //           child: ChangePasswordPage(),
            //         );
            //       },
            //     ),
            //     GoRoute(
            //       name: DeleteAccountPage.name,
            //       path: DeleteAccountPage.path,
            //       parentNavigatorKey: router.rootNavigatorKey,
            //       pageBuilder: (BuildContext context, GoRouterState state) {
            //         return const MaterialPage<void>(
            //           fullscreenDialog: true,
            //           child: DeleteAccountPage(),
            //         );
            //       },
            //     ),
            //   ],
            // ),
            GoRoute(
              name: SettingsPage.name,
              path: SettingsPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: SettingsPage());
              },
            ),
          ],
        ),
      ],
    );
  }
}
