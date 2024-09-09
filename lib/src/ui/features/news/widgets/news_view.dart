import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../../core/entities/news_message.dart';
import '../../../constants/sizes_constants.dart';
import '../../../localizations/l10n.dart';
import '../cubit/news_cubit.dart';
import 'news_message_card.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.newsPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (BuildContext context, NewsState state) {
            if (state is! NewsLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final NewsMessage newsMessage = state.newsMessages[index];
                return NewsMessageCard(
                  title: newsMessage.title,
                  newsMessage: newsMessage.message,
                  dateSubmitted: newsMessage.dateSubmitted,
                );
              },
              separatorBuilder: (_, __) => const GutterSmall(),
              itemCount: state.newsMessages.length,
            );
          },
        ),
      ),
    );
  }
}
