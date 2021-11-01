import '../app_config.dart';

void main() async {
  await FlutterAppConfig(
    environment: AppEnvironment.testing_owner,
    apiBaseUrl: 'https://my-api.com',
    appName: 'Flutter-App-Dev',
    initializeCrashlytics: false,
  ).run();
}
