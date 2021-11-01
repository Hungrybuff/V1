import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/Authentication/BLOC/AuthenticationBloc.dart';
import 'package:hungrybuff/owner/Authentication/State.dart';
import 'package:hungrybuff/owner/Authentication/UI/LoginScreen.dart';
import 'package:hungrybuff/owner/Authentication/UI/sign_up.dart';
import 'package:hungrybuff/owner/HomeModule/ui/home_screen.dart';
import 'package:hungrybuff/owner/Utils/data_display_widget.dart';
import 'package:hungrybuff/owner/admin/AdminScreen.dart';


class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Auth"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AuthenticationBloc _authenticationBloc = AuthenticationBloc.getInstance();
  StreamSubscription streamSubscription;
  @override
  Widget build(BuildContext context) {
    return DataDisplayWidget<AuthenticationState>(
      loadingWidget: loadingWidget(),
      activeWidget: activeWidget,
      stream: _authenticationBloc.authenticationStateStream,
      errorWidget: errorWidget(),
    );
  }
  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _authenticationBloc.checkUser();
    streamSubscription = _authenticationBloc.authenticationStateStream
        .listen(listenToAuthenticationState);
  }

  void listenToAuthenticationState(AuthenticationState event) async {
    switch (event) {
      case AuthenticationState.loading:
        // TODO: Handle this case.
        break;
      case AuthenticationState.noUser:
        goToSignUpScreen();
        break;
      case AuthenticationState.admin:
        goToAdminScreen();
        break;
      case AuthenticationState.owner:
        await goToOwnerScreen(_authenticationBloc.user);
        break;
      case AuthenticationState.error:
        goToErrorScreen();
        break;
    }
  }

  Widget errorWidget() {
    return new Text("data");
  }

  Widget loadingWidget() {
    return Center(child: new CircularProgressIndicator());
  }

  Widget activeWidget(AuthenticationState data) {
    switch (data) {
      case AuthenticationState.loading:
        return loadingWidget();
        break;
      case AuthenticationState.noUser:
        break;
      case AuthenticationState.admin:
        return loadingWidget();
        break;
      case AuthenticationState.owner:
        return loadingWidget();
        break;
      case AuthenticationState.error:
        return errorWidget();
        break;
    }
    return errorWidget();
  }

  Future<void> goToOwnerScreen(FirebaseUser currentUser) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OwnerHomeScreen()),
    );
  }

  void goToAdminScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AdminScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void goToErrorScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ErrorScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void goToLoginScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
    (Route<dynamic> route) => false,
    );
  }

  void goToSignUpScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
          (Route<dynamic> route) => false,
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final AuthenticationBloc _authenticationBloc =
      AuthenticationBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Center(
          child: new Text(
              "Error : ${_authenticationBloc.getError}, Please contact support.")),
    );
  }
}
