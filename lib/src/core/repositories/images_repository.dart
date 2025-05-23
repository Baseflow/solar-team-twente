import 'dart:typed_data';

abstract interface class ImagesRepository {
  Future<String> uploadImage(Uint8List imageData, String folder, String fileName);

  Future<String> deleteImage(String folder, String fileName);

  Future<String> getImageUrl(String folder, String fileName);
}
