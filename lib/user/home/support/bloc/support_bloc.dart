class SupportBloc {
  static SupportBloc _instance;

  SupportBloc._internal();

  static SupportBloc getInstance() {
    if (_instance == null) _instance = SupportBloc._internal();
    return _instance;
  }

  static getTitle() {
    return ('Support');
  }

  static String getHeading() {
    return 'Get Support';
  }
}
