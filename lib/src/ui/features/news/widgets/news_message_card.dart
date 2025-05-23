import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:intl/intl.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';

class NewsMessageCard extends StatelessWidget {
  const NewsMessageCard({required this.title, required this.newsMessage, required this.dateSubmitted, super.key});

  final String title;
  final String newsMessage;
  final DateTime dateSubmitted;

  @override
  Widget build(BuildContext context) {
    final String formattedSubmissionTime = DateFormat(
      'd MMM, hh:mm',
      context.locale.countryCode,
    ).format(dateSubmitted.toLocal());
    return Card(
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: context.colorScheme.primaryContainer,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: context.colorScheme.surface,
            child: ClipOval(
              child: SizedBox.square(
                dimension: 40,
                child: Image.asset(
                  context.theme.brightness == Brightness.dark ? Assets.dark.logo.path : Assets.light.logo.path,
                ),
              ),
            ),
          ),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(newsMessage),
            const GutterTiny(),
            Text(
              formattedSubmissionTime,
              textAlign: TextAlign.end,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.onPrimaryContainer.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
