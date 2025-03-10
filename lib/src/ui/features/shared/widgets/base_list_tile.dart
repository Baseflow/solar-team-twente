import 'package:flutter/material.dart';

/// A base list tile that simplifies the implementation of list tiles in this
/// app by adding a chevron right icon as default trailing icon and set the
/// widgets for the title and subtitle.
class BaseListTile extends ListTile {
  /// Creates a new instance of [BaseListTile].
  BaseListTile({
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    Icon trailingIcon = const Icon(Icons.chevron_right),
    Icon? leadingIcon,
    super.key,
  }) : super(
          title: Text(title, style: titleStyle),
          subtitle:
              subtitle != null ? Text(subtitle, style: subtitleStyle) : null,
          trailing: trailingIcon,
          leading: leadingIcon,
          onTap: onTap,
        );
}
