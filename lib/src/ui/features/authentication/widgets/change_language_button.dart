import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../settings/cubit/language_cubit.dart';
import '../../settings/views/language_page.dart';

/// The button to change the language.
class ChangeLanguageButton extends StatelessWidget {
  /// Creates a new instance of [ChangeLanguageButton].
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (BuildContext context, String languageCode) {
        return TextButton.icon(
          onPressed: () => context.pushNamed(LanguagePage.name),
          icon: Flag.fromString(
            context.read<LanguageCubit>().getCountryCode(),
            height: 20,
            width: 20,
          ),
          label: Text(
            languageCode.toUpperCase(),
          ),
        );
      },
    );
  }
}
