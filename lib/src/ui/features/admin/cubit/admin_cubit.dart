import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core.dart';
import '../types/admin_error_code.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit({required PostsService newsService})
    : _newsService = newsService,
      super(const AdminState(status: AdminStatus.initial));

  final PostsService _newsService;

  Future<void> submitPost() async {
    if (!state.isValid) {
      emit(state.copyWith(status: AdminStatus.error, errorCode: AdminErrorCode.missingContent));
      return;
    }

    emit(state.copyWith(status: AdminStatus.loading));

    await _newsService
        .submitMessage(
          Post(
            title: state.postTitle!,
            message: state.postBody!,
            type: state.postType!,
            location: state.postLocation!,
            images: state.postImageUrls!,
            videoUrl: state.postVideoUrl,
          ),
        )
        .catchError(
          (_) => emit(const AdminState(status: AdminStatus.error, errorCode: AdminErrorCode.sendingMessageFailed)),
        );

    if (state.errorCode != null) {
      return;
    }

    emit(
      AdminState(
        status: AdminStatus.messageSent,
        postTitle: state.postTitle,
        postBody: state.postBody,
        postType: state.postType,
        postLocation: state.postLocation,
        postImageUrls: state.postImageUrls,
        postVideoUrl: state.postVideoUrl,
      ),
    );
  }

  void titleChanged(String value) {
    emit(state.copyWith(postTitle: value));
  }

  void bodyChanged(String value) {
    emit(state.copyWith(postBody: value));
  }

  void typeChanged(PostType type) {
    emit(state.copyWith(postType: type));
  }

  void locationChanged(LatLng location) {
    emit(state.copyWith(postLocation: location));
  }

  void imageUrlsChanged(List<String> urls) {
    emit(state.copyWith(postImageUrls: urls));
  }

  void videoUrlChanged(String? url) {
    emit(state.copyWith(postVideoUrl: url));
  }
}
