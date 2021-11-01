import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/app/app_config.dart';
import 'package:hungrybuff/owner/Authentication/UI/auth_screen.dart';
import 'package:hungrybuff/state/shared_state.dart';
import 'package:hungrybuff/user/authentication/ui/SplashScreen.dart';

class FlutterApp extends StatefulWidget {
  FlutterApp({
    @required this.environment,
    @required this.appName,
  });

  final AppEnvironment environment;
  final String appName;

  @override
  State<StatefulWidget> createState() {
    return FlutterAppState();
  }
}

class FlutterAppState extends State<FlutterApp> {
  @override
  void initState() {
    super.initState();

    // TODO: Initialize any global services
    // - Push Notifications
    // - Crash Reporting (Firebase crashlytics)
    // - Connectivity monitoring
  }

  final theme =
      ThemeData(primaryColor: Colors.white, accentColor: Colors.orangeAccent);

  Widget determineHomeScreen(AppEnvironment environment) {
    switch (environment) {
      case AppEnvironment.development_owner:

      case AppEnvironment.staging_owner:

      case AppEnvironment.production_owner:

      case AppEnvironment.testing_owner:
        return AuthScreen();
        break;

      case AppEnvironment.development_user:

      case AppEnvironment.production_user:

      case AppEnvironment.testing_user:

      case AppEnvironment.staging_user:
        return SplashScreen();
        break;
    }
    return SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Banner(
      layoutDirection: TextDirection.ltr,
      textDirection: TextDirection.ltr,
      location: BannerLocation.topEnd,
      message: getMessage(widget.environment),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        title: widget.appName,
        theme: theme,
        home: determineHomeScreen(widget.environment),
        navigatorKey: SharedState.navigatorKey,
        navigatorObservers: [],
      ),
    );
  }

  @override
  void dispose() async {
    // TODO: dispose of any global services that were initialized
    super.dispose();
  }

  String getMessage(AppEnvironment environment) {
    switch(environment) {
      case AppEnvironment.development_owner:
        return "dev owner";
        break;
      case AppEnvironment.development_user:
        return "dev user";
        break;
      case AppEnvironment.production_owner:
      case AppEnvironment.production_user:
        return "";
        break;
      case AppEnvironment.testing_owner:
        return "testing owner";
        break;
      case AppEnvironment.testing_user:
        return "testing user";
        break;
      case AppEnvironment.staging_owner:
        return "staging owner";
        break;
      case AppEnvironment.staging_user:
        return "staging user";
        break;
      default:
        return "";
    }
  }
}
