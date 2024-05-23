import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core.dart' as core;
import 'clients/clients.dart';
import 'clients/solar_client.dart';
import 'data_stores/data_stores.dart';
import 'network/dio_factory.dart';
import 'repositories/repositories.dart' as data;

/// Initializes the data library ensuring all dependencies
/// are registered.
///
/// The `boostrap()` method is called from the `main.dart` file to bootstrap
/// the application.
Future<void> bootstrap() async {
  // This is a good place to initialize data specific libraries. For instance
  // if the application needs to communicate with Firebase, this is the perfect
  // location to call:
  /// await Firebase.initializeApp(
  ///     options: DefaultFirebaseOptions.currentPlatform,
  /// );

  // Register implementation for the repositories defined in the core library.
  await _registerDependencies();
}

Future<void> _registerDependencies() async {
  final IocContainer ioc = IocContainer.container;

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // Register API client implementations
  ioc

    // Register data dependencies needed for the Analytics feature.
    ..registerLazySingleton<core.AnalyticsRepository>(
      FirebaseAnalyticsClient.new,
    )

    // Register data dependencies needed for the Crashlytics feature.
    ..registerLazySingleton<core.CrashlyticsRepository>(
      FirebaseCrashlyticsClient.new,
    )

    // Register data dependencies needed for the Authentication feature.
    ..registerFactory<AuthenticationClient>(
      // TODO(mvanbeusekom): Replace the mock implementation with a real
      //implementation for client applications.
      MockAuthenticationClient.new,
    )
    ..registerFactory<TokenDataStore>(
      FlutterSecureStorageTokenDataStore.new,
    )
    ..registerLazySingleton<core.AuthenticationRepository>(
      () => data.AuthenticationRepository(
        authenticationClient: ioc.get<AuthenticationClient>(),
        tokenDataStore: ioc.get<TokenDataStore>(),
      ),
    )

    // Register data dependencies needed for the Language feature.
    ..registerFactory<core.LanguageRepository>(
      () => data.SharedPreferencesLanguageRepository(
        sharedPreferences: sharedPreferences,
      ),
    )
    // TODO(Anyone): Until auth is implemented the following code is commented.
    // ..registerLazySingleton<AuthenticationTokenInterceptor>(
    //   () => AuthenticationTokenInterceptor(
    //     authenticationRepository: ioc.get<core.AuthenticationRepository>(),
    //     dio: DioFactory.getOrCreateAuthenticationDio(),
    //   ),
    // )

    // Register data dependencies needed for the Project feature.
    ..registerFactory<core.ProjectRepository>(data.ApiProjectRepository.new)

    // Register data dependencies needed for the Profile feature.
    ..registerFactory<ProfileClient>(
      () => ProfileClient(DioFactory.getOrCreateGeneralDio()),
    )
    ..registerFactory<core.ProfileRepository>(
      () => data.ApiProfileRepository(ioc.get<ProfileClient>()),
    )
    ..registerFactory<SolarClient>(
      () => SolarClient(
        DioFactory.getOrCreateSolarDio(),
        baseUrl: core.AppConfig.solarUrl,
      ),
    )
    ..registerLazySingleton<core.LeaderboardRepository>(
      () => data.ApiLeaderboardRepository(solarClient: ioc.get<SolarClient>()),
    )

    // Register data dependencies needed for the Theme feature.
    ..registerFactory<core.ThemeRepository>(
      () => data.SharedPreferencesThemeRepository(
        sharedPreferences: sharedPreferences,
      ),
    );
}
