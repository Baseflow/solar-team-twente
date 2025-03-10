import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._newsService) : super(NewsInitial());

  final NewsService _newsService;

  late StreamSubscription<List<NewsMessage>> _newsSubscription;

  @override
  Future<void> close() {
    _newsSubscription.cancel();
    return super.close();
  }

  void initialize() {
    _newsSubscription = _newsService.messages.listen(
      (List<NewsMessage> newsMessages) {
        emit(NewsLoaded(newsMessages: newsMessages));
      },
      onError: (Object error) {
        emit(NewsError(newsMessages: state.newsMessages));
      },
    );
  }
}
