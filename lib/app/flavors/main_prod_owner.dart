import '../app_config.dart';

void main() async {
  await FlutterAppConfig(
    environment: AppEnvironment.production_owner,
    apiBaseUrl: 'https://my-api.com',
    appName: 'Flutter-App-Dev',
    initializeCrashlytics: true,
  ).run();
}
