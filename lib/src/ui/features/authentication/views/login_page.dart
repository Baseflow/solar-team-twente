import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../layouts/adaptive_split_layout.dart';
import '../../shared/cubits/about_cubit.dart';
import '../cubit/login_cubit.dart';
import 'login_view.dart';

/// The login page.
class LoginPage extends StatelessWidget {
  /// Creates a new instance of [LoginPage].
  const LoginPage({super.key});

  /// Path for the page.
  static const String path = '/login';

  /// The route for the page.
  static const String name = 'Login';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<StateStreamableSource<Object?>>>[
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(
            Ioc.container.get<AuthenticationService>(),
          ),
        ),
        BlocProvider<AboutCubit>(
          create: (BuildContext context) => AboutCubit()..fetchAppDetails(),
        ),
      ],
      child: AdaptiveSplitLayout(
        body: const LoginView(),
        secondaryBody: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              Assets.hero.path,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.s32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppConfig.appTitle,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                  const GutterSmall(),
                  BlocBuilder<AboutCubit, AboutState>(
                    builder: (BuildContext context, AboutState state) {
                      return Text(
                        state.appVersion,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
