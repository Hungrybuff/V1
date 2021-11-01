class Constants {
  //Routes
  static const String INITIAL_ROUTE = '/';
  static const String ABOUT_US = 'about-us';
  static const String TERMS_AND_CONDITIONS = '/termsncond';
  static const String LOGIN_SCREEN = '/login';
  static const String HOME_SCREEN = '/home';
  static const String SIGN_UP = '/Signup';

  static const int waitingForPayment = 10;
  static const int paymentFailed = 15;
  static const int waitingToBeAccepted = 30;
  static const int accepted = 40;
  static const int preparing = 50;
  static const int readyToBePicked = 60;

  static const int pendingOrder = 100;
  static const int orderRejected = 110;

  static const int closed = 150;
  static const int cancelled = 25;

  static const int finishedOrder = 200;

  static int cashPaymentMode = 0;
  static int cardPaymentMode = 1;
  static int gPayPaymentMode = 2;

  static const String DateTimeFormat = "dd/MM/yy HH:mm";
}
