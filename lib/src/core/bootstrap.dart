import 'package:flutter_ioc/flutter_ioc.dart';

import '../../core.dart';

/// Initializes the core library ensuring all dependencies are
/// registered.
///
/// The `bootstrap()` method is called from the `main.dart` file to
/// initialize the application.
Future<void> bootstrap() async {
  // Register all public services with the Inversion of Control container.
  _registerDependencies();
}

void _registerDependencies() {
  final IocContainer ioc = IocContainer.container;

  ioc
    ..registerLazySingleton<AnalyticsService>(
      () =>
          AnalyticsService(analyticsRepository: ioc.get<AnalyticsRepository>())
            ..initialize(),
    )
    ..registerLazySingleton<CrashlyticsService>(
      () => CrashlyticsService(
        crashlyticsRepository: ioc.get<CrashlyticsRepository>(),
      )..initialize(),
    )
    ..registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(
        authenticationRepository: ioc.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<LanguageService>(
      () => LanguageService(
        languageRepository: ioc.get<LanguageRepository>(),
      ),
    )
    ..registerFactory<ProfileService>(
      () => ProfileService(
        profileRepository: ioc.get<ProfileRepository>(),
      ),
    )
    ..registerFactory<ThemeService>(
      () => ThemeService(
        themeRepository: ioc.get<ThemeRepository>(),
      ),
    )
    ..registerFactory<VehicleLocationService>(
      () => VehicleLocationService(
        vehicleLocationRepository: ioc.get<VehicleLocationRepository>(),
      ),
    )
    ..registerFactory<NewsService>(
      () => NewsService(ioc.get<NewsRepository>()),
    )
    ..registerFactory<LeaderboardService>(
      () => LeaderboardService(
        leaderboardRepository: ioc.get<LeaderboardRepository>(),
      ),
    );
}
