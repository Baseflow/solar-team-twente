import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';
import '../../../layouts/adaptive_split_layout.dart';
import '../cubit/register_cubit.dart';
import 'register_view.dart';

/// The register page.
class RegisterPage extends StatelessWidget {
  /// Creates a new instance of [RegisterPage].
  const RegisterPage({super.key});

  /// Path for the page.
  static const String path = 'register';

  /// The route for the page.
  static const String name = 'Register';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (BuildContext context) => RegisterCubit(Ioc.container.get<AuthenticationService>()),
      child: AdaptiveSplitLayout(
        body: const RegisterView(),
        secondaryBody: Stack(
          fit: StackFit.expand,
          children: <Widget>[Image.asset(Assets.hero.path, fit: BoxFit.cover)],
        ),
      ),
    );
  }
}
