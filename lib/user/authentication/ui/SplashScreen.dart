import 'package:flutter/material.dart';
import 'package:hungrybuff/user/Authentication/bloc/AuthenticationBLOC.dart';
import 'package:hungrybuff/user/Authentication/ui/login_screen.dart';
import 'package:hungrybuff/user/authentication/introScreen/IntroScreen.dart';
import 'package:hungrybuff/user/home/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_up.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool goToIntro;
  SharedPreferences prefs;
  void checkUser() async {
    AuthenticationBLOC authenticationBLOC = AuthenticationBLOC.getInstance();
    authenticationBLOC.splashNavigationScreen(
        navigateToHomeScreen: pushHomeScreen,
        navigateToLogin: pushLogin,
        navigateToSignUP: pushSignUpScreen,
        error: error);
  }

  void error(String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildAlertDialog(context);
        });
  }

  Widget buildAlertDialog(BuildContext context) {
    return AlertDialog(
      content: new Text("Something Went Wrong! Please Retry"),
      actions: <Widget>[
        Container(
          decoration:
              new BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
          child: Center(
            child: new RaisedButton(
              color: Colors.deepOrange,
              onPressed: () {
                checkUser();
                Navigator.pop(context);
              },
              child: new Text(
                "Retry",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        )
      ],
    );
  }

  void initState() {
    super.initState();
    gotToIntro();
    checkUser();
  }

  void gotToIntro() async {
    prefs = await SharedPreferences.getInstance();
    print("prefs value " + prefs.getBool("CanGoToIntro").toString());

    setState(() {
      goToIntro = (prefs.getBool('CanGoToIntro') ?? true);
    });
  }

  void pushSignUpScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
        (Route<dynamic> route) => false);
  }

  void pushHomeScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false);
  }

  void pushLogin() {
    print("prefs value " + prefs.getBool("CanGoToIntro").toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => goToIntro ? IntroScreen() : LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
