import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';
import '../dto/news_message_dto.dart';

class SupabaseNewsRepository implements NewsRepository {
  SupabaseNewsRepository(this._client);

  final SupabaseClient _client;

  @override
  Stream<List<NewsMessage>> get newsMessages {
    final SupabaseStreamBuilder response = _client
        .from('news_messages')
        .stream(primaryKey: <String>['id']).order('created_at');

    return response.map((List<Map<String, dynamic>> data) {
      return data.map((Map<String, dynamic> json) {
        return NewsMessageDTO.fromJson(json).toEntity();
      }).toList();
    });
  }

  @override
  Future<void> submitNewsMessage(NewsMessage newsMessage) {
    return _client
        .from('news_messages')
        .upsert(NewsMessageDTO.fromEntity(newsMessage).toJson());
  }
}
