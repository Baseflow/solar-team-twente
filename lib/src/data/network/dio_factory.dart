import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core.dart' as core;

/// A factory class for creating instances of the Dio client.
final class DioFactory {
  DioFactory._();

  static final DioFactory _factory = DioFactory._();
  static final Map<String, Dio> _dioInstances = <String, Dio>{};

  /// Returns an instance of the Dio client used for all requests.
  static Dio getOrCreateGeneralDio() {
    const String key = 'general';

    if (_dioInstances.containsKey(key)) {
      return _dioInstances[key]!;
    }

    final Dio generalDio = _factory._createGeneralDio();
    _dioInstances[key] = generalDio;
    return generalDio;
  }

  /// Returns an instance of the Dio client used for authentication.
  static Dio getOrCreateAuthenticationDio() {
    const String key = 'authentication';

    if (_dioInstances.containsKey(key)) {
      return _dioInstances[key]!;
    }

    final Dio authenticationDio = _factory._createAuthenticationDio();
    _dioInstances[key] = authenticationDio;
    return authenticationDio;
  }

  Dio _createGeneralDio() {
    const String baseUrl = core.AppConfig.baseUrl;
    // The default value warning needs to be ignored because the baseUrl is
    // defined in the AppConfig class and retrieved from the environment.
    // ignore: avoid_redundant_argument_values
    final Dio generalDio = Dio(BaseOptions(baseUrl: baseUrl));
    generalDio.interceptors.addAll(<Interceptor>[
      RetryInterceptor(dio: generalDio),
      if (kDebugMode) PrettyDioLogger(requestHeader: true, requestBody: true),
      DioCacheInterceptor(options: CacheOptions(store: MemCacheStore())),
      // Until auth is implemented, the following code is commented out.
      // IocContainer.container.get<AuthenticationTokenInterceptor>(),
    ]);

    return generalDio;
  }

  Dio _createAuthenticationDio() {
    // The default value warning needs to be ignored because the baseUrl is
    // defined in the AppConfig class and retrieved from the environment.
    // ignore: avoid_redundant_argument_values
    return Dio(BaseOptions(baseUrl: core.AppConfig.authUrl))
      ..interceptors.addAll(<Interceptor>[if (kDebugMode) PrettyDioLogger(requestHeader: true, requestBody: true)]);
  }
}
