import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ioc_get_it/flutter_ioc_get_it.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core.dart' as core;
import 'data.dart' as data;
import 'firebase_options.dart';
import 'ui.dart' as ui;

Future<void> main() async {
  await runZonedGuarded(
    () async {
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();

      // Retain native splash screen until Dart is ready
      if (!kIsWeb) {
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      }

      // Load the environment variables from the .env file
      core.AppConfig.initialize(kdDebugMode: kDebugMode);

      // Initialize the GetIt Ioc Container.
      GetItIocContainer.register();

      
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      

      await data.bootstrap();
      await core.bootstrap();
      await ui.bootstrap();
    },
    (Object error, StackTrace stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}
