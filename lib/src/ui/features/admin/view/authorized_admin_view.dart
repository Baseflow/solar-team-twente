import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import '../cubit/admin_cubit.dart';
import '../types/admin_error_code.dart';

/// {@template authorized_admin_view}
/// The [AuthorizedAdminView] is the entry point to the admin view.
/// {@endtemplate}
class AuthorizedAdminView extends StatefulWidget {
  /// {@macro authorized_admin_view}
  const AuthorizedAdminView({required this.user, super.key});

  final User? user;

  @override
  State<AuthorizedAdminView> createState() => _AuthorizedAdminViewState();
}

class _AuthorizedAdminViewState extends State<AuthorizedAdminView> {
  late TextEditingController? _titleController;
  late TextEditingController? _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController?.dispose();
    _bodyController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: BlocProvider<AdminCubit>(
          create: (BuildContext context) => AdminCubit(newsService: Ioc.container.get<NewsService>()),
          child: BlocConsumer<AdminCubit, AdminState>(
            listenWhen: (AdminState previous, AdminState current) {
              return current is AdminMessageSent;
            },
            listener: (BuildContext context, AdminState state) {
              _titleController?.clear();
              _bodyController?.clear();
            },
            builder: (BuildContext context, AdminState state) {
              final AppLocalizations l10n = context.l10n;
              return Column(
                children: <Widget>[
                  Text(
                    l10n.adminNewsMessageTitle,
                    style: context.textTheme.titleLarge!.apply(color: context.colorScheme.primary),
                  ),
                  const Gutter(),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(border: const OutlineInputBorder(), hintText: l10n.title),
                    enabled: state is! AdminLoading,
                    onChanged: context.read<AdminCubit>().titleChanged,
                  ),
                  const Gutter(),
                  TextField(
                    maxLines: 8,
                    controller: _bodyController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: l10n.newsMessageBodyHintText,
                    ),
                    enabled: state is! AdminLoading,
                    onChanged: context.read<AdminCubit>().bodyChanged,
                  ),
                  const Gutter(),
                  if (state is AdminError) _ErrorContainer(state.errorCode),
                  if (state is AdminLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    FilledButton(
                      onPressed: context.read<AdminCubit>().submitNewsMessage,
                      child: Text(l10n.sendMessage),
                    ),
                  if (state is AdminMessageSent) ...<Widget>[const Gutter(), const _MessageSubmittedContainer()],
                  const GutterLarge(),
                  Text('${l10n.signedInAs}: ${widget.user?.email}'),
                  const GutterTiny(),
                  TextButton(onPressed: context.read<AuthenticationCubit>().signOut, child: Text(l10n.signOut)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorContainer extends StatelessWidget {
  const _ErrorContainer(this.errorCode);

  final AdminErrorCode errorCode;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.s16),
      decoration: BoxDecoration(
        color: context.colorScheme.error.withValues(alpha: 0.1),
        border: Border.all(color: context.colorScheme.error),
        borderRadius: BorderRadius.circular(Sizes.s4),
      ),
      padding: const EdgeInsets.all(Sizes.s8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: context.colorScheme.error),
          const GutterSmall(),
          Text(switch (errorCode) {
            AdminErrorCode.missingTitleOrBody => l10n.missingTitleOrBoddyErrorMessage,
            AdminErrorCode.sendingMessageFailed => l10n.sendingMessageFailedErrorMessage,
          }, style: context.textTheme.bodyMedium!.apply(color: context.colorScheme.error)),
        ],
      ),
    );
  }
}

class _MessageSubmittedContainer extends StatelessWidget {
  const _MessageSubmittedContainer();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.s16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(Sizes.s4),
      ),
      padding: const EdgeInsets.all(Sizes.s8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
          const GutterSmall(),
          Text(l10n.messageSent, style: context.textTheme.bodyMedium!.apply(color: Colors.green)),
        ],
      ),
    );
  }
}
