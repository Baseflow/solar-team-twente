import 'dart:typed_data';

import '../repositories/repositories.dart';

class ImagesService {
  const ImagesService({required ImagesRepository imagesRepository}) : _imagesRepository = imagesRepository;

  final ImagesRepository _imagesRepository;

  Future<String> uploadImage(Uint8List imageData, String folder, String fileName) {
    return _imagesRepository.uploadImage(imageData, folder, fileName);
  }

  Future<String> deleteImage(String folder, String fileName) {
    return _imagesRepository.deleteImage(folder, fileName);
  }

  Future<String> getImageUrl(String folder, String fileName) {
    return _imagesRepository.getImageUrl(folder, fileName);
  }
}
