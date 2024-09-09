import '../entities/news_message.dart';

class NewsService {
  Stream<List<NewsMessage>> get messages {
    return Stream<List<NewsMessage>>.fromIterable(
      <List<NewsMessage>>[
        <NewsMessage>[
          NewsMessage(
            title: 'Title 1',
            message: 'News message 1',
            dateSubmitted: DateTime.now(),
          ),
          NewsMessage(
            title: 'Title 2',
            message: 'News message 2',
            dateSubmitted: DateTime.now().subtract(
              const Duration(days: 1),
            ),
          ),
          NewsMessage(
            title: 'Title 3',
            message: 'News message 3',
            dateSubmitted: DateTime.now().subtract(
              const Duration(days: 2),
            ),
          ),
          NewsMessage(
            title: 'Title 4',
            message: 'News message 4',
            dateSubmitted: DateTime.now().subtract(
              const Duration(days: 3),
            ),
          ),
          NewsMessage(
            title: 'Title 5',
            message: 'News message 5',
            dateSubmitted: DateTime.now().subtract(
              const Duration(days: 4),
            ),
          ),
        ],
      ],
    );
  }
}
