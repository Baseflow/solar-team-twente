import '../../../core.dart';

class NewsService {
  NewsService(this._repository);

  final PostsRepository _repository;

  Stream<List<Post>> get messages => _repository.newsMessages;

  Future<void> submitMessage(Post message) {
    return _repository.submitPost(message);
  }
}
