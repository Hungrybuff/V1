import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hungrybuff/model/event_model.dart';
import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/model/user_details.dart';
import 'package:hungrybuff/user/home/home/home_repo/home_repo.dart';

class HomeBloc {
  static HomeBloc _instance;
  FirebaseUser _currentUser;
  HomeRepo hRepo;

  static HomeBloc getInstance() {
    if (_instance == null) _instance = HomeBloc._internal();
    return _instance;
  }

  HomeBloc._internal() {
    hRepo = HomeRepo.getInstance();
  }

  @deprecated
  Future<List<FoodTruck>> getList() {
    return hRepo.getList();
  }

  Future<List<FoodTruck>> getFList() {
    return hRepo.getFList();
  }

  Future<List<Event>> getEList() {
    return hRepo.getEList();
  }

  Future<String> getUserName() async {
    print("get name called ");
    if (_currentUser == null)
      _currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection("users")
        .document(_currentUser.uid)
        .get();
    UserDetails user = UserDetails.fromJson(documentSnapshot.data);
    print(
        "Get name returned ${user.firstName} for user ID = ${_currentUser.uid}");
    return user.firstName;
  }
}
