import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../localizations/generated/app_localizations.dart';
import '../../localizations/l10n.dart';
import 'team_member_view_model.dart';

/// {@template team_details_view}
/// The view displaying the details of the team competing in this edition.
/// {@endtemplate}
class TeamDetailsView extends StatefulWidget {
  /// {@macro team_details_view}
  const TeamDetailsView({super.key});

  @override
  State<TeamDetailsView> createState() => _TeamDetailsViewState();
}

class _TeamDetailsViewState extends State<TeamDetailsView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.teamPageTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                // height: carouselHeight,
                aspectRatio: 1.8,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: _imageSliders,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 60,
                right: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    teamMember[_currentIndex].getDescriptionText(context),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const Gutter(),
                  FilledButton.tonalIcon(
                    onPressed: () =>
                        _launchURL(teamMember[_currentIndex].linkedUrl),
                    label: const Text(
                      'LinkedIn profile',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    iconAlignment: IconAlignment.end,
                  ),
                  const Gutter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Widget> _imageSliders = teamMember
    .map(
      (TeamMember member) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: member.imageUrl,
                    fit: BoxFit.cover,
                    //width: 500,
                    placeholder: (BuildContext context, String url) =>
                        const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget:
                        (BuildContext context, String url, Object error) =>
                            const Icon(Icons.error),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            member.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            member.profession,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    .toList();

Future<void> _launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.inAppBrowserView);
  } else {
    throw UnimplementedError('Could not launch $url');
  }
}
