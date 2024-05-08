import 'package:flutter/material.dart';

import 'profile_view.dart';

/// The page displaying the profile of the user.
class ProfilePage extends StatelessWidget {
  /// Creates a new instance of [ProfilePage].
  const ProfilePage({super.key});

  /// The path of the [ProfilePage] route.
  static const String path = 'profile';

  /// The name of the [ProfilePage] route.
  static const String name = 'Profile';

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}
