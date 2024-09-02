import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/admin/admin_page.dart';
import '../features/dashboard/views/dashboard_page.dart';
import '../features/leaderboard/views/leaderboard_page.dart';
import '../features/live/views/live_page.dart';
import '../features/more/views/more_page.dart';
import '../features/news/widgets/news_page.dart';
import '../features/settings/views/settings_page.dart';
import '../features/team/team_details_page.dart';
import 'app_scaffold_shell.dart';
import 'global_router.dart' as router show rootNavigatorKey;

final GlobalKey<NavigatorState> _liveNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final GlobalKey<NavigatorState> _newsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'news');
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
          navigatorKey: _dashboardNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              name: DashboardPage.routeName,
              path: DashboardPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: DashboardPage());
              },
              routes: <RouteBase>[
                GoRoute(
                  name: TeamDetailsPage.routeName,
                  path: TeamDetailsPage.path,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const MaterialPage<void>(
                      child: TeamDetailsPage(),
                    );
                  },
                ),
                GoRoute(
                  name: LeaderboardPage.routeName,
                  path: LeaderboardPage.path,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const MaterialPage<void>(
                      child: LeaderboardPage(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _liveNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              name: LivePage.routeName,
              path: LivePage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: LivePage());
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _newsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              name: NewsPage.routeName,
              path: NewsPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: NewsPage());
              },
            ),
          ],
        ),
        _morePageRoutes,
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
            GoRoute(
              name: AdminPage.routeName,
              path: AdminPage.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage<void>(child: AdminPage());
              },
            ),
          ],
        ),
      ],
    );
  }
}
