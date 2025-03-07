import 'package:flutter_ioc/flutter_ioc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core.dart';
import 'clients/clients.dart';
import 'data_stores/data_stores.dart';
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
    url: AppConfig.baseUrl,
    anonKey: AppConfig.supabaseAnonKey,
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
    ..registerLazySingleton<AnalyticsRepository>(FirebaseAnalyticsClient.new)
    // Register data dependencies needed for the Crashlytics feature.
    ..registerLazySingleton<CrashlyticsRepository>(
      FirebaseCrashlyticsClient.new,
    )
    // Register supabase client as a singleton.
    ..registerLazySingleton<SupabaseClient>(() => Supabase.instance.client)
    ..registerFactory<TokenDataStore>(FlutterSecureStorageTokenDataStore.new)
    ..registerLazySingleton<AuthenticationRepository>(
      () => SupabaseAuthenticationRepository(
        authenticationClient: ioc.get<SupabaseClient>(),
        tokenDataStore: ioc.get<TokenDataStore>(),
      ),
    )
    // Register other data dependencies.
    ..registerFactory<LanguageRepository>(
      () => SharedPreferencesLanguageRepository(
        sharedPreferences: sharedPreferences,
      ),
    )
    ..registerFactory<ThemeRepository>(
      () => SharedPreferencesThemeRepository(
        sharedPreferences: sharedPreferences,
      ),
    )
    ..registerFactory<VehicleLocationRepository>(
      () =>
          SupabaseVehicleLocationRepository(client: ioc.get<SupabaseClient>()),
    )
    ..registerFactory<NewsRepository>(
      () => SupabaseNewsRepository(ioc.get<SupabaseClient>()),
    )
    ..registerFactory<LeaderboardRepository>(
      () => SupabaseLeaderboardRepository(ioc.get<SupabaseClient>()),
    );
}
