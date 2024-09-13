import '../../../core.dart';

abstract interface class NewsRepository {
  Stream<List<NewsMessage>> get newsMessages;

  Future<void> submitNewsMessage(NewsMessage newsMessage);
}
