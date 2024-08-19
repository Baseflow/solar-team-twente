import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/sizes_constants.dart';
import '../../localizations/generated/app_localizations.dart';
import '../../localizations/l10n.dart';
import 'team_member_view_model.dart';

/// {@template team_details_view}
/// The view displaying the details of the team competing in this edition.
/// {@endtemplate}
class TeamDetailsView extends StatefulWidget {
  /// {@macro team_details_view}
  TeamDetailsView({required BuildContext context, super.key})
      : teamMembers = _getTeamMembers(context);
  final List<TeamMember> teamMembers;

  @override
  State<TeamDetailsView> createState() => _TeamDetailsViewState();

  static List<TeamMember> _getTeamMembers(BuildContext context) {
    return <TeamMember>[
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/bc27ce2695/laura-voogd_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Laura Voogd',
        profession: 'Team Manager',
        description: context.l10n.descriptionLaura,
        linkedUrl: 'https://www.linkedin.com/in/laura-voogd-94232521a/',
      ),
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/198264f270/jeroen-pouwels_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Jeroen Pouwels',
        description: context.l10n.descriptionJeroen,
        profession: 'Account Manager',
        linkedUrl: 'https://www.linkedin.com/in/jeroen-pouwels/',
      ),
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/dfa9cf0cd4/daan-de-jong_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Daan De Jong',
        description: context.l10n.descriptionDaanDeJong,
        profession: 'Technical / Logistics Manager',
        linkedUrl: 'https://www.linkedin.com/in/daan-de-jong-a79b92197/',
      ),
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/02af73a59f/esmee-hulsman_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Esmee Hulsman',
        description: context.l10n.descriptionEsmee,
        profession: 'Marketing & Communications / PR',
        linkedUrl: 'https://www.linkedin.com/in/esmee-hulsman-b6a03222b/',
      ),
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/9cc1481f31/daan-nibbering_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Daan Nibbering',
        description: context.l10n.descriptionDaanNibbering,
        profession: 'Strategist',
        linkedUrl: 'https://www.linkedin.com/in/daan-nibbering-a09883221/',
      ),
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/7f12ad31dc/roosmarijn-meijers_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Roosmarijn Meijers',
        description: context.l10n.descriptionRoosmarijn,
        profession: 'Electrical Engineer',
        linkedUrl: 'https://www.linkedin.com/in/roosmarijn-meijers-291415217/',
      ),
      TeamMember(
        imageUrl:
            'https://a.storyblok.com/f/281680/640x450/c05a4f11a0/vera-leeman_640x450.png/m/640x450/smart/filters:quality(80)',
        name: 'Vera Leeman',
        description: context.l10n.descriptionVera,
        profession: 'Research & Development Manager',
        linkedUrl: 'https: //www.linkedin.com/in/vera-leeman-75a688218/',
      ),
    ];
  }
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
        padding: const EdgeInsets.only(top: Sizes.s32),
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
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
              items: _imageSliders(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: Sizes.s32,
                left: Sizes.s64,
                right: Sizes.s64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.teamMembers[_currentIndex].description,
                    style: const TextStyle(
                      fontSize: Sizes.s12,
                    ),
                  ),
                  const Gutter(),
                  FilledButton.tonalIcon(
                    onPressed: () =>
                        _launchURL(widget.teamMembers[_currentIndex].linkedUrl),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.s12,
                      ),
                    ),
                    label: const Text(
                      'LinkedIn profile',
                      style: TextStyle(
                        fontSize: Sizes.s12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.open_in_new, size: Sizes.s16),
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

  List<Widget> _imageSliders() {
    return widget.teamMembers.map(
      (TeamMember member) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.s24),
                ),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: member.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (BuildContext context, String url) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorWidget:
                          (BuildContext context, String url, Object error) {
                        return const Icon(Icons.error);
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.black87,
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.s12,
                          horizontal: Sizes.s24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              member.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.s16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              member.profession,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.s12,
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
        );
      },
    ).toList();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.inAppBrowserView);
    } else {
      throw UnimplementedError('Could not launch $url');
    }
  }
}
