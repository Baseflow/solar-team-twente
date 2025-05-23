import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';
import '../dto/post_dto.dart';

class SupabasePostsRepository implements PostsRepository {
  SupabasePostsRepository(this._client);

  final SupabaseClient _client;

  @override
  Stream<List<Post>> get newsMessages {
    final SupabaseStreamBuilder response = _client
        .from('news_messages') // TODO(triqoz): Refactor when backend is ready
        .stream(primaryKey: <String>['id'])
        .order('created_at');

    return response.map((List<Map<String, dynamic>> data) {
      return data.map((Map<String, dynamic> json) {
        return PostDto.fromJson(json).toEntity();
      }).toList();
    });
  }

  @override
  Future<void> submitPost(Post post) {
    return _client.from('news_messages').upsert(PostDto.fromEntity(post).toJson());
  }
}
