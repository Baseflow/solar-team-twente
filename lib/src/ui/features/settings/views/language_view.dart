import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale_names/locale_names.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/language_cubit.dart';

/// The page displaying the language settings.
class LanguageView extends StatelessWidget {
  /// Creates a new instance of [LanguageView].
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Locale> locales = AppLocalizations.supportedLocales;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.language)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: Sizes.s24),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: Sizes.s16),
            itemCount: locales.length,
            itemBuilder: (BuildContext context, int index) {
              final Locale locale = locales[index];
              return RadioListTile<String>(
                title: Text(
                  locale.nativeDisplayLanguage.capitalize(),
                  style: context.textTheme.bodyLarge?.copyWith(fontSize: 20),
                ),
                value: locale.languageCode,
                groupValue: context.watch<LanguageCubit>().state,
                onChanged: (String? value) {
                  if (value == null) return;
                  try {
                    context.read<LanguageCubit>().changeLanguage(value);
                  } on Exception {
                    context.showSnackBar(SnackBar(content: Text(context.l10n.changeLanguageError)));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

extension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
