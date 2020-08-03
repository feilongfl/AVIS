import 'MyApp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/AppShareData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  bool isInDebugMode = false;
//
//  FlutterError.onError = (FlutterErrorDetails details) {
//    if (isInDebugMode) {
//       In development mode simply print to console.
//      FlutterError.dumpErrorToConsole(details);
//    } else {
//       In production mode report to the application zone to report to
//       Crashlytics.
//      Zone.current.handleUncaughtError(details.exception, details.stack);
//    }
//  };
//
//  await FlutterCrashlytics().initialize();
//
//  runZoned<Future<Null>>(() async {
  AppShareData.prefs = await SharedPreferences.getInstance();
  runApp(AppShareData(child: MyApp()));
//  }, onError: (error, stackTrace) async {
//     Whenever an error occurs, call the `reportCrash` function. This will send
//     Dart errors to our dev console or Crashlytics depending on the environment.
//    await FlutterCrashlytics()
//        .reportCrash(error, stackTrace, forceCrash: false);
//  });
}
