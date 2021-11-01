import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hungrybuff/owner/models/User.dart';
import 'package:hungrybuff/owner/admin/Model/OwnerFoodTruck.dart';
import 'package:rxdart/rxdart.dart';

import 'Model/OwnerFoodTruck.dart';

class AdminBloc {
  AdminBloc instance;

  BehaviorSubject<QuerySnapshot> ownersStreamController =
      new BehaviorSubject<QuerySnapshot>();

  String userEmail;

  Stream<QuerySnapshot> get ownersStream => ownersStreamController.stream;

  BehaviorSubject<DocumentSnapshot> userStreamController =
      new BehaviorSubject<DocumentSnapshot>();

  Stream<DocumentSnapshot> get userStream => userStreamController.stream;

  BehaviorSubject<QuerySnapshot> usersListController =
      new BehaviorSubject<QuerySnapshot>();

  Stream<QuerySnapshot> get usersListStream => usersListController.stream;

  AdminBloc getInstance() {
    if (instance == null) instance = new AdminBloc();
    return instance;
  }

  Future<void> addFoodTruck(String truckName, String description,
      String ownerId, double fromTime, double toTime) async {
    String foodTruckId = getUniqueID();
    OwnerFoodTruck foodTruck = new OwnerFoodTruck(
        truckName,
        null,
        0,
        null,
        false,
        true,
        null,
        "https://images.unsplash.com/photo-1492168732976-2676c584c675?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
        null,
        description,
        foodTruckId,
        fromTime,
        toTime,
        ownerId,
        new List(),
    );
    /* DocumentReference reference =
        await Firestore.instance.collection("trucks").add(foodTruck.toJson());*/
    await Firestore.instance
        .collection("trucks")
        .document(foodTruckId)
        .setData(foodTruck.toJson());
    await Firestore.instance
        .collection("users")
        .document(ownerId)
        .updateData({"foodTruckId": foodTruckId});
  }

  String getUniqueID() {
    return FirebaseDatabase.instance.reference().push().key;
  }

  Future<User> loadAdminProfile() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot =
        await Firestore.instance.collection("users").document(user.uid).get();
    User userData = new User.fromMap(snapshot.data);
    return userData;
  }

  Future<void> loadAllUsers() async {
    CollectionReference reference = Firestore.instance.collection("users");
    QuerySnapshot snapshot = await reference.getDocuments();
    addLatestData(snapshot);
    reference.snapshots().listen((event) {
      addLatestData(event);
    });
  }

  void addLatestData(QuerySnapshot event) {
    usersListController.add(event);
  }

  Future<void> makeUserAsOwner(User user, String userPath) async {
    await Firestore.instance
        .collection("users")
        .document(userPath)
        .updateData({"role": "owner"});
  }

  Future<void> loadOwners() async {
    var reference = Firestore.instance
        .collection("users")
        .where("role", isEqualTo: "owner");
    QuerySnapshot snapshot = await reference.getDocuments();
    ownersStreamController.add(snapshot);
    reference.snapshots().listen((event) {
      ownersStreamController.add(event);
    });
  }

  Future<void> removeFoodTruck(String truckId, String userId) async {
    await Firestore.instance
        .collection("users")
        .document(userId)
        .updateData({"role": null, "foodTruckId": null});
    await Firestore.instance.collection("trucks").document(truckId).delete();
  }

  void search(String text) {
    this.userEmail = text;
    Firestore.instance
        .collection("users")
        .where("emailAddress", isEqualTo: text)
        .snapshots()
        .listen((event) {
      try {
        userStreamController.add(event.documents[0]);
      } catch (error) {
        print(error);
        userStreamController.add(null);
      }
    });
  }
}
