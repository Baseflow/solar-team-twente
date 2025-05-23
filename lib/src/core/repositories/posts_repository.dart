import '../../../core.dart';

abstract interface class PostsRepository {
  Stream<List<Post>> get posts;

  Future<void> submitPost(Post post);
}
