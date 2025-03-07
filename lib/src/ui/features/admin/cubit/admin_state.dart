part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {
  const AdminState({this.newsMessageTitle, this.newsMessageBody});

  final String? newsMessageTitle;
  final String? newsMessageBody;

  AdminState copyWith({String? newsMessageTitle, String? newsMessageBody});
}

class AdminInitial extends AdminState {
  const AdminInitial({super.newsMessageTitle, super.newsMessageBody});

  @override
  List<Object?> get props => <Object?>[newsMessageTitle, newsMessageBody];

  @override
  AdminState copyWith({String? newsMessageTitle, String? newsMessageBody}) {
    return AdminInitial(
      newsMessageTitle: newsMessageTitle ?? this.newsMessageTitle,
      newsMessageBody: newsMessageBody ?? this.newsMessageBody,
    );
  }
}

class AdminError extends AdminState {
  const AdminError({
    required this.errorCode,
    super.newsMessageTitle,
    super.newsMessageBody,
  });

  final AdminErrorCode errorCode;

  @override
  List<Object?> get props => <Object?>[
    errorCode,
    newsMessageTitle,
    newsMessageBody,
  ];

  @override
  AdminState copyWith({
    String? newsMessageTitle,
    String? newsMessageBody,
    AdminErrorCode? errorCode,
  }) {
    return AdminError(errorCode: errorCode ?? this.errorCode);
  }
}

class AdminMessageSent extends AdminState {
  const AdminMessageSent({
    required String super.newsMessageTitle,
    required String super.newsMessageBody,
  });

  @override
  List<Object> get props => <Object>[newsMessageTitle!, newsMessageBody!];

  @override
  AdminState copyWith({String? newsMessageTitle, String? newsMessageBody}) {
    return AdminMessageSent(
      newsMessageTitle: newsMessageTitle ?? this.newsMessageTitle!,
      newsMessageBody: newsMessageBody ?? this.newsMessageBody!,
    );
  }
}

class AdminLoading extends AdminState {
  const AdminLoading({super.newsMessageBody, super.newsMessageTitle});

  @override
  List<Object?> get props => <Object?>[newsMessageTitle, newsMessageBody];

  @override
  AdminState copyWith({String? newsMessageTitle, String? newsMessageBody}) {
    return AdminLoading(
      newsMessageTitle: newsMessageTitle ?? this.newsMessageTitle,
      newsMessageBody: newsMessageBody ?? this.newsMessageBody,
    );
  }
}
