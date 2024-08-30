import 'package:latlong2/latlong.dart';

/// The constants of the application.
class Constants {
  /// The Solarteam name.
  static const String solarTeamName = 'Solar Team Twente';

  /// The application legalese.
  static const String applicationLegalese = '©2024 ' 'Baseflow';

  /// The application website.
  static const String appWebsite = 'https://www.solarteam.nl';

  /// The privacy policy.
  static const String appPrivacyPolicy = 'https://www.baseflow.com/privacy';

  /// The terms and conditions.
  static const String termsAndConditions =
      'https://assets.website-files.com/6005500917c6de66daae5341/6017ccadab020f74208417c3_baseflow_terms_conditions.pdf';

  /// The start date of the event.
  static DateTime startDate = DateTime(2024, 9, 13);

  static bool get hasRaceStarted => startDate.isBefore(DateTime.now());

  static List<List<LatLng>> coordinates = <List<LatLng>>[
    <LatLng>[
      const LatLng(-27.318422, 27.824081),
      const LatLng(-26.320134, 29.18415),
    ],
    <LatLng>[
      const LatLng(-26.8903773, 26.082086),
      const LatLng(-25.517609, 27.831684),
    ],
    <LatLng>[
      const LatLng(-27.471608, 23.402627),
      const LatLng(-25.541249, 26.082988),
    ],
    <LatLng>[
      const LatLng(-28.769597, 20.341723),
      const LatLng(-27.471124, 23.402675),
    ],
    <LatLng>[
      const LatLng(-29.662415, 17.887869),
      const LatLng(-28.623128, 20.534983),
    ],
    <LatLng>[
      const LatLng(-31.748007, 17.833363),
      const LatLng(-29.661212, 18.730951),
    ],
    <LatLng>[
      const LatLng(-33.380566, 18.340278),
      const LatLng(-31.559386, 18.899053),
    ],
    <LatLng>[
      const LatLng(-34.026167, 18.422593),
      const LatLng(-33.300209, 19.49382),
    ],
    <LatLng>[
      const LatLng(-27.318422, 27.824081),
      const LatLng(-26.320134, 29.18415),
      const LatLng(-31.748007, 17.833363),
      const LatLng(-29.661212, 18.730951),
      const LatLng(-33.3805549630841, 18.8992070280719),
      const LatLng(-33.9079862706016, 18.4225931269598),
    ],
  ];
}
