import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/profile_cubit.dart';
import 'profile_content.dart';

/// The page displaying the profile of the user.
class ProfileView extends StatelessWidget {
  /// Creates a new instance of [ProfileView].
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myAccount),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            return switch (state) {
              ProfileLoadedState _ => const ProfileContent(),
              ProfileErrorState _ => Center(child: Text(l10n.errorLoadingPage)),
              _ => const Center(child: CircularProgressIndicator()),
            };
          },
        ),
      ),
    );
  }
}
