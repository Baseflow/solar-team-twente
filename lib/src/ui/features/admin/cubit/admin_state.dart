part of 'admin_cubit.dart';

enum AdminStatus { initial, loading, error, messageSent }

class AdminState extends Equatable {
  const AdminState({
    required this.status,
    this.postTitle,
    this.postBody,
    this.postLocation,
    this.postImageUrls,
    this.postType,
    this.postVideoUrl,
    this.errorCode,
  });

  final AdminStatus status;
  final String? postTitle;
  final String? postBody;
  final LatLng? postLocation;
  final List<String>? postImageUrls;
  final PostType? postType;
  final String? postVideoUrl;

  final AdminErrorCode? errorCode;

  bool get isValid {
    return (postTitle?.isNotEmpty ?? false) &&
        (postBody?.isNotEmpty ?? false) &&
        postLocation != null &&
        postType != null &&
        (postImageUrls?.isNotEmpty ?? false);
  }

  AdminState copyWith({
    AdminStatus? status,
    String? postTitle,
    String? postBody,
    LatLng? postLocation,
    List<String>? postImageUrls,
    PostType? postType,
    String? postVideoUrl,
    AdminErrorCode? errorCode,
  }) {
    return AdminState(
      status: status ?? this.status,
      postTitle: postTitle ?? this.postTitle,
      postBody: postBody ?? this.postBody,
      postLocation: postLocation ?? this.postLocation,
      postImageUrls: postImageUrls ?? this.postImageUrls,
      postType: postType ?? this.postType,
      postVideoUrl: postVideoUrl ?? this.postVideoUrl,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    postTitle,
    postBody,
    postLocation,
    postImageUrls,
    postType,
    postVideoUrl,
    errorCode,
  ];
}
