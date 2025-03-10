import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/more/views/terms_and_conditions_page.dart';
import '../features/settings/views/language_page.dart';

/// Stores the routes that are accessible from multiple parts from the app.
class SharedRoutes {
  /// The route for the login page.
  static List<GoRoute> get values {
    return <GoRoute>[
      GoRoute(
        name: LanguagePage.name,
        path: LanguagePage.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(child: LanguagePage());
        },
      ),
      GoRoute(
        name: TermsAndConditionsPage.name,
        path: TermsAndConditionsPage.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(child: TermsAndConditionsPage());
        },
      ),
    ];
  }
}
