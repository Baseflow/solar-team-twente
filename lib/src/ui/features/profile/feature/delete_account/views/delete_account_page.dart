import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../../../core.dart';
import '../cubit/delete_account_cubit.dart';
import 'delete_account_view.dart';

/// The [DeleteAccountPage] page allows a user to delete their account.
class DeleteAccountPage extends StatelessWidget {
  /// Creates a new instance of [DeleteAccountPage].
  const DeleteAccountPage({super.key});

  /// The path of the [DeleteAccountPage] route.
  static const String path = 'delete-account';

  /// The name of the [DeleteAccountPage] route.
  static const String name = 'DeleteAccount';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteAccountCubit>(
      create: (_) => DeleteAccountCubit(
        Ioc.container.get<ProfileService>(),
      ),
      child: const DeleteAccountView(),
    );
  }
}
