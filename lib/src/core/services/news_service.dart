import '../../../core.dart';

class NewsService {
  NewsService(this._repository);

  final NewsRepository _repository;

  Stream<List<NewsMessage>> get messages => _repository.newsMessages;

  Future<void> submitMessage(NewsMessage message) {
    return _repository.submitNewsMessage(message);
  }
}
