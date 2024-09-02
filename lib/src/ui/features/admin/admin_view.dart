import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../../constants/sizes_constants.dart';
import '../dashboard/views/dashboard_page.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s12),
        child: SupaMagicAuth(
          onSuccess: (_) => context.go(DashboardPage.path),
          redirectUrl: kIsWeb ? null : 'solarteam://auth',
        ),
      ),
    );
  }
}
