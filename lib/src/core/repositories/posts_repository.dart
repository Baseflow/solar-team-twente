import '../../../core.dart';

abstract interface class PostsRepository {
  Stream<List<Post>> get newsMessages;

  Future<void> submitPost(Post post);
}
