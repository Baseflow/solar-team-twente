import 'package:flutter/material.dart';

import '../../localizations/l10n.dart';

/// {@template team_member}
/// The data related to a team member:
/// {@endtemplate}
class TeamMember {
  ///{@macro team_member}
  const TeamMember({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.profession,
    required this.linkedUrl,
  });

  final String name;
  final String Function(BuildContext context) description;
  final String imageUrl;
  final String profession;
  final String linkedUrl;

  String getDescriptionText(BuildContext context) => description(context);
}

final List<TeamMember> teamMember = <TeamMember>[
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/bc27ce2695/laura-voogd_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Laura Voogd',
    profession: 'Team Manager',
    description: (BuildContext context) => context.l10n.descriptionLaura,
    linkedUrl: 'https://www.linkedin.com/in/laura-voogd-94232521a/',
  ),
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/198264f270/jeroen-pouwels_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Jeroen Pouwels',
    description: (BuildContext context) => context.l10n.descriptionJeroen,
    profession: 'Account Manager',
    linkedUrl: 'https://www.linkedin.com/in/jeroen-pouwels/',
  ),
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/dfa9cf0cd4/daan-de-jong_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Daan De Jong',
    description: (BuildContext context) => context.l10n.descriptionDaanDeJong,
    profession: 'Technical / Logistics Manager',
    linkedUrl: 'https://www.linkedin.com/in/daan-de-jong-a79b92197/',
  ),
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/02af73a59f/esmee-hulsman_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Esmee Hulsman',
    description: (BuildContext context) => context.l10n.descriptionEsmee,
    profession: 'Marketing & Communications / PR',
    linkedUrl: 'https://www.linkedin.com/in/esmee-hulsman-b6a03222b/',
  ),
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/9cc1481f31/daan-nibbering_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Daan Nibbering',
    description: (BuildContext context) =>
        context.l10n.descriptionDaanNibbering,
    profession: 'Strategist',
    linkedUrl: 'https://www.linkedin.com/in/daan-nibbering-a09883221/',
  ),
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/7f12ad31dc/roosmarijn-meijers_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Roosmarijn Meijers',
    description: (BuildContext context) => context.l10n.descriptionRoosmarijn,
    profession: 'Electrical Engineer',
    linkedUrl: 'https://www.linkedin.com/in/roosmarijn-meijers-291415217/',
  ),
  TeamMember(
    imageUrl:
        'https://a.storyblok.com/f/281680/640x450/c05a4f11a0/vera-leeman_640x450.png/m/640x450/smart/filters:quality(80)',
    name: 'Vera Leeman',
    description: (BuildContext context) => context.l10n.descriptionVera,
    profession: 'Research & Development Manager',
    linkedUrl: 'https://www.linkedin.com/in/vera-leeman-75a688218/',
  ),
];
