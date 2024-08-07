/// The application configuration.
///
/// These values can be set using the `.env` file which you can copy form
/// `.env.example`.
///
/// The configuration file is past into the compiler using the
/// `--dart-define-from-file` argument. For example if you want to create a
/// production build:
/// ```shell
/// flutter build apk --dart-define-from-file=.env.prod
/// ```
class AppConfig {
  /// Creates a new instance of [AppConfig].
  AppConfig._(
    this.kDebugMode,
  );

  /// The [AppConfig] instance.
  static late AppConfig _instance;

  /// Initializes the [AppConfig] instance by setting [_instance] using the
  /// private constructor.
  static void initialize({
    bool kdDebugMode = false,
  }) {
    _instance = AppConfig._(kdDebugMode);
  }

  /// Whether the application is in debug mode.
  final bool kDebugMode;

  /// The current application flavor.
  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'development');

  /// The application ID.
  static const String appId = String.fromEnvironment('APP_ID');

  /// The application title.
  static const String appTitle = String.fromEnvironment('APP_TITLE');

  /// The base URL.
  static const String baseUrl = String.fromEnvironment('BASE_URL');

  /// The authentication URL.
  static const String authUrl = String.fromEnvironment('AUTH_URL');

  /// Supabase specific anon key, unique to the supabase project.
  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY');
}
