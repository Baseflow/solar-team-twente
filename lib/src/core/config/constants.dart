/// The constants of the application.
class Constants {
  /// The Solarteam name.
  static const String solarTeamName = 'Solar Team Twente';

  /// The application legalese.
  static const String applicationLegalese = '©2025 ' 'Baseflow';

  /// The application website.
  static const String appWebsite = 'https://www.solarteam.nl';

  /// The privacy policy.
  static const String appPrivacyPolicy = 'https://www.baseflow.com/privacy';

  /// The terms and conditions.
  static const String termsAndConditions =
      'https://assets.website-files.com/6005500917c6de66daae5341/6017ccadab020f74208417c3_baseflow_terms_conditions.pdf';

  /// The start date of the event.
  static DateTime startDate = DateTime(2025, 9, 13);

  static bool get hasRaceStarted => startDate.isBefore(DateTime.now());
}
