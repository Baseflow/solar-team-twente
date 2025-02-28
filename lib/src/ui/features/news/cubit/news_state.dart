part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState({required this.newsMessages});

  final List<NewsMessage> newsMessages;
}

class NewsInitial extends NewsState {
  NewsInitial() : super(newsMessages: <NewsMessage>[]);

  @override
  List<Object> get props => <Object>[newsMessages];
}

class NewsLoaded extends NewsState {
  const NewsLoaded({required super.newsMessages});

  @override
  List<Object> get props => <Object>[newsMessages];
}

class NewsError extends NewsState {
  const NewsError({required super.newsMessages});

  @override
  List<Object> get props => <Object>[newsMessages];
}
