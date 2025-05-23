import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/repositories/images_repository.dart';

class SupabaseImagesRepository implements ImagesRepository {
  SupabaseImagesRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<String> uploadImage(Uint8List imageData, String folder, String fileName) async {
    try {
      await _client.storage.from(folder).uploadBinary(fileName, imageData);

      return getImageUrl(folder, fileName);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Future<String> deleteImage(String folder, String fileName) async {
    try {
      final List<FileObject> result = await _client.storage.from(folder).remove(<String>[fileName]);

      if (result.isEmpty) {
        throw Exception('File not found or already deleted');
      }

      return 'Image deleted successfully';
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  @override
  Future<String> getImageUrl(String folder, String fileName) async {
    try {
      final String url = _client.storage.from(folder).getPublicUrl(fileName);

      return url;
    } catch (e) {
      throw Exception('Failed to get image URL: $e');
    }
  }
}
