import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hungrybuff/model/splash_screen_data.dart';
import 'package:hungrybuff/model/user_details.dart';
import 'package:hungrybuff/user/Authentication/repo/AuthenticationREPO.dart';

class AuthenticationBLOC {
  static AuthenticationBLOC _instance;

  String verificationID = "";

  UserDetails userDetails;

  String password;

  Timer _timer;

  int timeOut = 15;

  static AuthenticationBLOC getInstance() {
    if (_instance == null) {
      _instance = new AuthenticationBLOC();
    }
    return _instance;
  }

  AuthenticationRepository repo = AuthenticationRepository.getInstance();

  Future<void> createNewUser(
      {@required Function alreadyExistingUser,
      @required Function(UserDetails userDetails) navigateToOTPScreen,
      @required Function passwordIsWeak,
      @required UserDetails userDetails,
      @required String password,
      @required Function(String error) error,
      @required Function loading,
      @required Function navigateToSplashScreen}) async {
    if (password == null || password.length < 6) {
      passwordIsWeak.call();
    }
    loading.call();
    this.password = password;
    this.userDetails = userDetails;
    navigateToOTPScreen.call(userDetails);
    verifyPhoneNumber(
        alreadyExistingUser: alreadyExistingUser,
        navigateToOTPScreen: navigateToOTPScreen,
        passwordIsWeak: passwordIsWeak,
        error: error,
        loading: loading,
        navigateToSplashScreen: navigateToSplashScreen);
  }

  Future<void> verifyPhoneNumber(
      {@required Function alreadyExistingUser,
      @required Function(UserDetails userDetails) navigateToOTPScreen,
      @required Function passwordIsWeak,
      @required Function(String error) error,
      @required Function loading,
      @required Function navigateToSplashScreen}) async {
    if (_timer == null)
      _timer = new Timer(Duration(seconds: timeOut), () {
        _timer = null;
      });
    else {
      error.call("wait for timer");
      return;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userDetails.phoneNumber,
        timeout: Duration(seconds: 15),
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          try {
            AuthResult authResult = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: userDetails.emailAddress, password: password);
            if (authResult == null) {
              error.call("cannot create user with this email address");
              return;
            }
            FirebaseUser currentUser =
                await FirebaseAuth.instance.currentUser();
            currentUser.linkWithCredential(phoneAuthCredential);
            await repo.saveUserDetails(userDetails);
            navigateToSplashScreen.call();
          } on Exception catch (e) {
            switch (e.toString()) {
              case "ERROR_EMAIL_ALREADY_IN_USE":
                alreadyExistingUser.call();
                return;
            }
          }
        },
        verificationFailed: (AuthException authException) {
          print("Phone Verification failed " + authException.message);
          error.call("Phone Verification failed " + authException.message);
        },
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: codeRetrievalTimeOut);
  }

  Future<void> splashNavigationScreen(
      {@required Function navigateToHomeScreen,
      @required Function navigateToLogin,
      @required Function navigateToSignUP,
      @required Function(String error) error,
      Function navigateToBlockedUser}) async {
    //Getting the instance of current user from Firebase Auth library
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    print(currentUser);
    if (currentUser == null) {
      //If the current user is null, it means user did not login yet.
      // Hence moving the user to login screen
      navigateToLogin.call();
    } else {
      print(currentUser.uid);
      // Since the current user is not null,
      // we will check with the repository for the user data
      SplashScreenData splashScreenData = await repo.getCurrentUserDetails();

      if (splashScreenData.isError) {
        error.call("Error please try again later");
        return;
      }

      //Checking for any inValid or blocked user
      if (splashScreenData.isUserValidUser) {
        // Checking if the user gave all personal details
        if (splashScreenData.didUserGiveAllTheDetials) {
          //Navigating the user to home screen if all details are available
          navigateToHomeScreen.call();
        } else {
          // Navigating the user to sign up if user did not provide all details
          await FirebaseAuth.instance.signOut();
          navigateToLogin.call();
        }
      } else {
        // Navigating the user to dead screen if the user if invalid or blocked
        navigateToBlockedUser.call();
      }
    }
    return;
  }

  Future<void> logOutUser({Function navigateToSplash}) async {
    await FirebaseAuth.instance.signOut();
    navigateToSplash.call();
    return;
  }

  void onCodeSent(String verificationId, [int forceResendingToken]) {
    this.verificationID = verificationId;
  }

  void codeRetrievalTimeOut(String verificationId) {
    print("Code retrieval timeout");
  }

  Future<void> login(
      {@required String email,
      @required String password,
      @required Function loginSuccessGoToSplash,
      @required Function wrongCombination,
      @required Function noUserWithThisEmailAddress}) async {
    try {
      AuthResult user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user == null) {
        noUserWithThisEmailAddress.call();
      } else {
        loginSuccessGoToSplash.call();
      }
    } catch (e) {
      print('login try catch error' + e.toString());
      wrongCombination.call();
    }
  }

  Future<void> onOTPSubmit(
      {@required String pin,
      @required Function wrongOTP,
      @required Function navigateToSplashScreen,
      @required Function error}) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationID, smsCode: pin);
    if (authCredential == null) {
      wrongOTP.call();
    } else {
      AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userDetails.emailAddress, password: password);
      if (authResult == null) {
        error.call();
        return;
      }
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      currentUser.linkWithCredential(authCredential);
      await repo.saveUserDetails(userDetails);
      navigateToSplashScreen.call();
    }
  }

  Future resetPassword(String email) async{
    print('Hoping to print something here $email');
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> resendPassword(
      {@required Function alreadyExistingUser,
      @required Function(UserDetails userDetails) navigateToOTPScreen,
      @required Function passwordIsWeak,
      @required Function(String error) error,
      @required Function loading,
      @required Function navigateToSplashScreen}) async {
    await verifyPhoneNumber(
        alreadyExistingUser: alreadyExistingUser,
        navigateToOTPScreen: navigateToOTPScreen,
        passwordIsWeak: passwordIsWeak,
        error: error,
        loading: loading,
        navigateToSplashScreen: navigateToSplashScreen);
    return;
  }
}
