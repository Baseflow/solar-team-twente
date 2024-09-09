import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../core.dart';
import '../../../localizations/l10n.dart';
import '../cubit/news_cubit.dart';
import 'news_view.dart';

/// Page for showing the news messages from the team to the fans.
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  /// The path of the dashboard page.
  static const String path = '/news';

  /// The route name of the dashboard page.
  static const String routeName = 'NewsPage';

  /// The destination for the [NewsPage] route.
  ///
  /// This is necessary for the bottom navigation bar to display the correct
  /// icon and label for the page, as well as to navigate to the page.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.newsPageTitle,
      selectedIcon: const Icon(Icons.message_rounded),
      icon: const Icon(Icons.message_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (_) => NewsCubit(
        Ioc.container.get<NewsService>(),
      )..initialize(),
      child: const NewsView(),
    );
  }
}
