import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/counter/view/counter_page.dart';
import '../features/more/views/more_page.dart';
import '../features/more/views/terms_and_conditions_page.dart';
import '../features/profile/feature/delete_account/views/delete_account_page.dart';
import '../features/profile/views/change_password_page.dart';
import '../features/profile/views/profile_page.dart';
import '../features/projects/views/example_details_page.dart';
import '../features/projects/views/new_example_page.dart';
import '../features/projects/views/project_overview_page.dart';
import '../features/settings/views/settings_page.dart';
import 'app_scaffold_shell.dart';
import 'global_router.dart' as router show rootNavigatorKey;

final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _counterNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'counter');
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
        _homeRoutes,
        StatefulShellBranch(
          navigatorKey: _counterNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              name: CounterPage.name,
              path: CounterPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: CounterPage());
              },
            ),
          ],
        ),
        _morePageRoutes,
      ],
    );
  }

  static StatefulShellBranch get _homeRoutes {
    return StatefulShellBranch(
      navigatorKey: _homeNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
          name: ProjectOverviewPage.name,
          path: ProjectOverviewPage.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage<void>(
              child: ProjectOverviewPage(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              name: ExampleDetailsPage.name,
              path: ExampleDetailsPage.path,
              parentNavigatorKey: router.rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(
                  child: ExampleDetailsPage(),
                );
              },
            ),
            GoRoute(
              name: NewExamplePage.name,
              path: NewExamplePage.path,
              parentNavigatorKey: router.rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(
                  fullscreenDialog: true,
                  child: NewExamplePage(),
                );
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
            GoRoute(
              path: ProfilePage.path,
              name: ProfilePage.name,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: ProfilePage());
              },
              routes: <RouteBase>[
                GoRoute(
                  path: ChangePasswordPage.path,
                  name: ChangePasswordPage.name,
                  parentNavigatorKey: router.rootNavigatorKey,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const MaterialPage<void>(
                      fullscreenDialog: true,
                      child: ChangePasswordPage(),
                    );
                  },
                ),
                GoRoute(
                  name: DeleteAccountPage.name,
                  path: DeleteAccountPage.path,
                  parentNavigatorKey: router.rootNavigatorKey,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const MaterialPage<void>(
                      fullscreenDialog: true,
                      child: DeleteAccountPage(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: SettingsPage.name,
              path: SettingsPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: SettingsPage());
              },
            ),
            GoRoute(
              name: TermsAndConditionsPage.name,
              path: TermsAndConditionsPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(
                  child: TermsAndConditionsPage(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
