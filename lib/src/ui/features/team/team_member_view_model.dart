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
  final String description;
  final String imageUrl;
  final String profession;
  final String linkedUrl;
}
