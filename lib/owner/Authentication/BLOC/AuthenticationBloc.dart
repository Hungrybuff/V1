import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/Authentication/State.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc {
  static AuthenticationBloc _instance;

  FirebaseUser user;

  final authenticationStateController =
  new BehaviorSubject<AuthenticationState>();

  String verificationId;

  Stream<AuthenticationState> get authenticationStateStream =>
      authenticationStateController.stream;

  String error = "";

  get getError => error;

  static AuthenticationBloc getInstance() {
    if (_instance == null) _instance = new AuthenticationBloc();
    return _instance;
  }

  AuthenticationBloc() {
    setStateAsLoading();
  }

  Future<void> setStateAsNoUser() async {
    authenticationStateController.add(AuthenticationState.noUser);
  }

  Future<void> addNewUserWith(
      String email, String password, String phoneNumber, String otp) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: otp);
    user = await FirebaseAuth.instance.currentUser();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: new Duration(seconds: 30),
        verificationCompleted: (phoneAuthCredential) async {
          user.linkWithCredential(phoneAuthCredential);
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {},
        codeSent: (verificationId, [forceResendingToken]) async {
          AuthCredential authCredential = PhoneAuthProvider.getCredential(
              verificationId: verificationId, smsCode: otp);
          user.linkWithCredential(authCredential);
        },
        codeAutoRetrievalTimeout: null);
  }

  void setStateAsLoading() {
    authenticationStateController.add(AuthenticationState.loading);
  }

  Future<void> setStateAsOwner() async {
    //await OwnerHomeBloc.getInstance().init();
    authenticationStateController.add(AuthenticationState.owner);
  }

  void setStateAsAdmin() {
    authenticationStateController.add(AuthenticationState.admin);
  }

  void setStateAsError() {
    authenticationStateController.add(AuthenticationState.error);
  }

  Future<void> checkUser() async {
    user = await FirebaseAuth.instance.currentUser();
    print("check user called");
    if (user == null) {
      print("user is null");
      setStateAsNoUser();
    } else {
      print("user is not null");
      QuerySnapshot snapshot = await Firestore.instance
          .collection("users")
          .where("emailAddress", isEqualTo: user.email)
          .getDocuments();
      if (snapshot.documents.length > 1) {
        print("Multiple documents exist with this email");
        error = "error code 1";
        setStateAsError();
      } else if (snapshot.documents.length == 1) {
        if (snapshot.documents[0].data["role"] != null) {
          if (snapshot.documents[0].data["role"] == "admin") {
            print("Setting state as Admin");
            setStateAsAdmin();
          } else if (snapshot.documents[0].data["role"] == "owner") {
            print("Setting state as Owner");
            setStateAsOwner();
          } else {
            error = "Some strange error occurred! Hang on. Error code is 4";
            setStateAsError();
          }
        } else {
          error = "You are not a owner!";
          setStateAsError();
        }
      } else if (snapshot.documents.length == 0) {
        error = "Error code 0";
        setStateAsError();
      }
    }
    _instance = null;
    return;
  }

//todo Check following cases
/*
* Wrong email
* Wrong password
* Not an Admin or owner
* No user found
* Network/Some other  error
* */
 /* Future<void> login(
      {@required String email, @required String password}) async {
    setStateAsLoading();
    print("Loggin in with $email and $password ");
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (authResult == null ) {
      print("Worng combination");
      setStateAsNoUser();
      return;
    }
    else if(authResult.user==null){
      authenticationStateController.add(AuthenticationState.noUser);
    }

    return checkUser();
  }*/
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
}
