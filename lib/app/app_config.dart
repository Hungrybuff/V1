import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app.dart';

enum AppEnvironment {
  development_owner,
  development_user,
  production_owner,
  production_user,
  testing_owner,
  testing_user,
  staging_owner,
  staging_user,
}

class FlutterAppConfig {
  FlutterAppConfig({
    @required this.appName,
    @required this.environment,
    @required this.apiBaseUrl,
    this.initializeCrashlytics = true,
    this.monitorConnectivity = true,
    this.enableCrashlyiticsInDevMode = true,
  });

  final String appName;
  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool initializeCrashlytics,
      monitorConnectivity,
      enableCrashlyiticsInDevMode;

  Future startCrashlytics() async {
    if (this.initializeCrashlytics) {
      Crashlytics.instance.enableInDevMode = enableCrashlyiticsInDevMode;
      FlutterError.onError = (FlutterErrorDetails details) {
        Crashlytics.instance.onError(details);
      };
    }
  }

  Widget createApp() {
    return FlutterApp(
      appName: this.appName,
      environment: environment,
    );
  }

  Future run() async {
    await startCrashlytics();

    runApp(createApp());
  }
}
