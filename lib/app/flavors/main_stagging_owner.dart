import '../app_config.dart';

void main() async {
  await FlutterAppConfig(
    environment: AppEnvironment.staging_owner,
    apiBaseUrl: 'https://my-api.com',
    appName: 'Flutter-App-Dev',
    initializeCrashlytics: false,
  ).run();
}
