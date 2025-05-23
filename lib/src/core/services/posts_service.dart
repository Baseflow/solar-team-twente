import '../../../core.dart';

class PostsService {
  PostsService(this._repository);

  final PostsRepository _repository;

  Stream<List<Post>> get messages => _repository.posts;

  Future<void> submitMessage(Post message) {
    return _repository.submitPost(message);
  }
}
