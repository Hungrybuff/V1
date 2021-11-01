import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/Authentication/BLOC/AuthenticationBloc.dart';
import 'package:hungrybuff/owner/Authentication/UI/auth_screen.dart';
import 'package:hungrybuff/owner/Authentication/UI/sign_up.dart';
import 'package:hungrybuff/owner/HomeModule/ui/home_screen.dart';
import 'package:hungrybuff/owner/admin/AdminScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthenticationBloc _authenticationBloc = AuthenticationBloc.getInstance();
  TextEditingController emailController = new TextEditingController(text: "");
  TextEditingController passwordController =
      new TextEditingController(text: "");
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Welcome ', style: welcomeStyle),
                    TextSpan(text: 'Stall Owner', style: stallStyle),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Enter your information below',
                    style: greyStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          'Email ID',
                          style: toolStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: emailController,
                                onSubmitted: (val) =>
                                    FocusScope.of(context).nextFocus(),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                maxLines: 1,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          'Password',
                          style: toolStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: passwordController,
                                onSubmitted: (val) =>
                                    FocusScope.of(context).nextFocus(),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                obscureText: _visible,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(_visible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _visible = !_visible;
                                        });
                                      },
                                      color: Colors.deepOrange,
                                    )),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print('Forgot Password Clicked');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: greyStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () {
                      _authenticationBloc.login(
                        email: emailController.text,
                        password: passwordController.text,
                        loginSuccessGoToSplash: gotoSplashScreen,
                        noUserWithThisEmailAddress: noUserFound,
                        wrongCombination: checkEmailAndPassword,
                      );
                    },
                    child: Container(
                      height: 54.0,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                              colors: [Colors.orange, Colors.deepOrange])),
                      child: Text(
                        'SIGN IN',
                        style: signInStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Dont have an account?',
                        style: greyStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print('Sign up clicked');
                          goToSignUp();
                        },
                        child: Text(
                          'Click here to Sign up',
                          style: signUpStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToOwnerScreen(FirebaseUser user) {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => OwnerHomeScreen()),
    );
  }

  void goToAdminScreen() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdminScreen()),
    );
  }

  void goToSignUp() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  TextStyle toolStyle = new TextStyle(
      color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.normal);

  TextStyle welcomeStyle = new TextStyle(
      color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.normal);

  TextStyle stallStyle = new TextStyle(
      color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.bold);

  TextStyle greyStyle = new TextStyle(
      fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w500);

  TextStyle signUpStyle = new TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline);

  TextStyle forgotStyle = new TextStyle(
      color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle signInStyle = new TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle clickStyle = new TextStyle(
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      color: Colors.black);

  @override
  void dispose() {
    super.dispose();
  }

  void gotoSplashScreen() {
    print("Moving to Auth/Splash Screen");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => new AuthScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void noUserFound() {
    showAlertDialog(context, "error", "No User found with this details");
  }

  void checkEmailAndPassword() {
    showAlertDialog(context, "Check Details", "Incorrect Email or Password");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
