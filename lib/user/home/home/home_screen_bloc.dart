import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  final presentIndexStreamController = new BehaviorSubject<int>();

  FirebaseUser _firebaseUser;

  Stream<int> get presentIndexStream => presentIndexStreamController.stream;

  static HomeScreenBloc _instance;

  FirebaseUser get getCurrentUser => _firebaseUser;

  static HomeScreenBloc getInstance() {
    if (_instance == null) {
      print("creating new instance ");
      _instance = HomeScreenBloc();
    }
    return _instance;
  }

  HomeScreenBloc() {
    initFirebaseUser();
  }

  void onStepChange(int event) {
    presentIndexStreamController.add(event);
  }

  Stream<int> getStream() {
    return presentIndexStream;
  }

  Future<void> initFirebaseUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
  }
}
