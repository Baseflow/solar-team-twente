part of 'about_cubit.dart';

/// The state of the about feature.
class AboutState {
  /// Creates a new instance of [AboutState].
  AboutState({this.appName = '', this.appVersion = ''});

  /// The name of the app.
  final String appName;

  /// The version of the app.
  final String appVersion;
}
