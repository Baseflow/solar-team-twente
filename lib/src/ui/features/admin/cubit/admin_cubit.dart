import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../types/admin_error_code.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit({required NewsService newsService}) : _newsService = newsService, super(const AdminInitial());

  final NewsService _newsService;

  Future<void> submitNewsMessage() async {
    if (state.newsMessageTitle == null ||
        state.newsMessageBody == null ||
        state.newsMessageTitle!.isEmpty ||
        state.newsMessageBody!.isEmpty) {
      emit(
        AdminError(
          errorCode: AdminErrorCode.missingTitleOrBody,
          newsMessageBody: state.newsMessageBody,
          newsMessageTitle: state.newsMessageTitle,
        ),
      );
      return;
    }

    emit(AdminLoading(newsMessageTitle: state.newsMessageTitle, newsMessageBody: state.newsMessageBody));

    await _newsService
        .submitMessage(NewsMessage(title: state.newsMessageTitle!, message: state.newsMessageBody!))
        .catchError((_) => emit(const AdminError(errorCode: AdminErrorCode.sendingMessageFailed)));

    if (state is AdminError) {
      return;
    }

    emit(AdminMessageSent(newsMessageTitle: state.newsMessageTitle!, newsMessageBody: state.newsMessageBody!));
  }

  void titleChanged(String value) {
    emit(AdminInitial(newsMessageBody: state.newsMessageBody, newsMessageTitle: value));
  }

  void bodyChanged(String value) {
    emit(AdminInitial(newsMessageBody: value, newsMessageTitle: state.newsMessageTitle));
  }
}
