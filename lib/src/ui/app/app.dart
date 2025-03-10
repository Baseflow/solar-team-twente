import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core.dart';
import '../features/authentication/cubit/authentication_cubit.dart';
import '../features/settings/cubit/language_cubit.dart';
import '../features/settings/cubit/theme_cubit.dart';
import '../localizations/generated/app_localizations.dart';
import '../navigation/global_router.dart';
import '../themes/app_theme.dart';
import '../themes/app_theme_extensions.dart';

/// This widget is the entry-point of the Widget-tree.
class App extends StatelessWidget {
  /// Creates a new [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<Cubit<Object>>>[
        BlocProvider<AuthenticationCubit>(
          create: (BuildContext context) => AuthenticationCubit(
            Ioc.container.get<AuthenticationService>(),
          )..ensureValidToken(),
        ),
        BlocProvider<LanguageCubit>(
          create: (BuildContext languageContext) {
            final String defaultLanguageCode = _defaultLanguageCode(context);
            return LanguageCubit(
              languageService: Ioc.container.get<LanguageService>(),
              defaultLanguageCode: defaultLanguageCode,
            )..fetchLanguage();
          },
        ),
        BlocProvider<ThemeCubit>(
          create: (_) {
            return ThemeCubit(Ioc.container.get<ThemeService>())..loadTheme();
          },
        ),
      ],
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listenWhen: (
          AuthenticationState previous,
          AuthenticationState current,
        ) {
          return previous.authStatus != current.authStatus &&
              current.authStatus != AuthenticationStatus.initializing;
        },
        listener: (BuildContext context, AuthenticationState state) {
          if (!kIsWeb) {
            FlutterNativeSplash.remove();
          }
        },
        child: Builder(
          builder: (BuildContext context) {
            return MaterialApp.router(
              restorationScopeId: AppConfig.appId,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: GlobalRouter.router,
              locale: context.watch<LanguageCubit>().currentLocale,
              theme: AppTheme.light().theme,
              darkTheme: AppTheme.dark().theme,
              highContrastTheme: AppTheme.highContrast().theme,
              highContrastDarkTheme: AppTheme.highContrastDark().theme,
              themeMode: context.watch<ThemeCubit>().state.toThemeMode(),
              builder: (BuildContext context, Widget? child) {
                return AccessibilityTools(child: child);
              },
            );
          },
        ),
      ),
    );
  }

  String _defaultLanguageCode(BuildContext context) {
    return View.of(context).platformDispatcher.locale.languageCode;
  }
}
