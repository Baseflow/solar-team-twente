import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core.dart' as core;
import 'clients/clients.dart';
import 'data_stores/data_stores.dart';
import 'network/dio_factory.dart';
import 'repositories/leaderboard_repository.dart';
import 'repositories/repositories.dart';
import 'repositories/vehicle_location_repository.dart';

/// Initializes the data library ensuring all dependencies
/// are registered.
///
/// The `boostrap()` method is called from the `main.dart` file to bootstrap
/// the application.
Future<void> bootstrap() async {
  await Supabase.initialize(
    url: core.AppConfig.baseUrl,
    anonKey: core.AppConfig.supabaseAnonKey,
  );

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

    // Register supabase client as a singleton.
    ..registerLazySingleton<SupabaseClient>(
      () => Supabase.instance.client,
    )
    ..registerFactory<TokenDataStore>(
      FlutterSecureStorageTokenDataStore.new,
    )
    ..registerLazySingleton<core.AuthenticationRepository>(
      () => SupabaseAuthenticationRepository(
        authenticationClient: ioc.get<SupabaseClient>(),
        tokenDataStore: ioc.get<TokenDataStore>(),
      ),
    )

    // Until auth is implemented, the following code is commented out.
    // ..registerLazySingleton<AuthenticationTokenInterceptor>(
    //   () => AuthenticationTokenInterceptor(
    //     authenticationRepository: ioc.get<core.AuthenticationRepository>(),
    //     dio: DioFactory.getOrCreateAuthenticationDio(),
    //   ),
    // )

    // Register data dependencies needed for the Profile feature.
    ..registerFactory<ProfileClient>(
      () => ProfileClient(
        DioFactory.getOrCreateGeneralDio(),
      ),
    )
    ..registerFactory<core.ProfileRepository>(
      () => ApiProfileRepository(ioc.get<ProfileClient>()),
    )

    // Register other data dependencies.
    ..registerFactory<core.LanguageRepository>(
      () => SharedPreferencesLanguageRepository(
        sharedPreferences: sharedPreferences,
      ),
    )
    ..registerFactory<core.ThemeRepository>(
      () => SharedPreferencesThemeRepository(
        sharedPreferences: sharedPreferences,
      ),
    )
    ..registerFactory<core.VehicleLocationRepository>(
      () => SupabaseVehicleLocationRepository(
        client: ioc.get<SupabaseClient>(),
      ),
    )
    ..registerFactory<core.LeaderboardRepository>(
      () => SupabaseLeaderboardRepository(
        ioc.get<SupabaseClient>(),
      ),
    );
}
