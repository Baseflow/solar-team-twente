import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';
import '../views/example_details_page.dart';

/// A card that represents a project.
class ProjectCard extends StatelessWidget {
  /// Creates a new instance of [ProjectCard].
  const ProjectCard({
    required this.name,
    required this.description,
    super.key,
  });

  /// The name of the project.
  final String name;

  /// The description of the project.
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Image.asset(
              context.isDarkMode
                  ? Assets.dark.logo.path
                  : Assets.light.logo.path,
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.goNamed(ExampleDetailsPage.name),
      ),
    );
  }
}
