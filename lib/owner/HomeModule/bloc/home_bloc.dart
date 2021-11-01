import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/owner/models/User.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class OwnerHomeBloc {
  final presentStreamController = new BehaviorSubject<int>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position position;

  FirebaseUser currentUser;
  String foodTruckID;

  FoodTruck foodTruck;

  Stream<int> get presentStream => presentStreamController.stream;

  BehaviorSubject<FoodTruck> foodTruckStreamController =
      new BehaviorSubject<FoodTruck>();

  Stream<FoodTruck> get truckStream => foodTruckStreamController.stream;

  BehaviorSubject<User> myProfileStreamController = new BehaviorSubject<User>();

  Stream<User> get myProfileStream => myProfileStreamController.stream;

  static OwnerHomeBloc _instance;

  static OwnerHomeBloc getInstance() {
    if (_instance == null) {
      print('Creating instance in HomeBloc');
      _instance = OwnerHomeBloc();
    }

    return _instance;
  }

  OwnerHomeBloc() {
    init();
  }

  Future<void> init() async {
    if (currentUser != null) return;
    currentUser = await FirebaseAuth.instance.currentUser();
    print(currentUser.uid);
    QuerySnapshot value = await Firestore.instance
        .collection("trucks")
        .where("ownerId", isEqualTo: currentUser.uid)
        .getDocuments();
    foodTruck = new FoodTruck.fromJson(value.documents[0].data);
    foodTruckStreamController.add(foodTruck);
    foodTruckID = value.documents[0].documentID;
    print(foodTruckID);
    loadTruckStream(foodTruckID);
  }

  void onEventChange(int event) {
    presentStreamController.add(event);
  }

  Stream<int> getStream() {
    return presentStream;
  }

  List getList() {
    return new List();
  }

  Future<Stream<QuerySnapshot>> getTrucksStream() async {
    if (currentUser == null)
      currentUser = await FirebaseAuth.instance.currentUser();
    print("Current user uid:" + currentUser.uid);
    return Firestore.instance
        .collection("trucks")
        .where("ownerId", isEqualTo: currentUser.uid)
        .snapshots();
  }

  Future<String> getFoodTruckName() async {
    if (foodTruck == null) await init();
    return foodTruck.foodTruckName;
  }

  Future<void> getLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      this.position = position;
      print("getLocation CurrentPosition get");
      updateLocation(position);
    }).catchError((e) {
      print("error from getLocation" + e);
    });
  }

  Future<void> updateFoodTruckSubTitles(String value) async {
    List<String> subtitles =
        foodTruck.subTitles != null ? foodTruck.subTitles : new List();
    if (subtitles.contains(value)) {
      //Nothing to update
    } else {
      subtitles.add(value);
      await Firestore.instance
          .collection("trucks")
          .document(foodTruckID)
          .updateData({"subTitles": subtitles});
    }
  }

  Future<void> updateFoodTruck(
      String name, String description, PickedFile file) async {
    if (file == null) {
      Firestore.instance.collection("trucks").document(foodTruckID).updateData({
        "foodTruckName": name,
        "description": description,
      });
    } else {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('foodTrucks' + foodTruckID);
      StorageUploadTask uploadTask = storageReference.putFile(File(file.path));
      await uploadTask.onComplete;
      print('File Uploaded');
      return storageReference.getDownloadURL().then((fileURL) async {
        await Firestore.instance
            .collection("trucks")
            .document(foodTruckID)
            .updateData({
          "foodTruckName": name,
          "description": description,
          "images": fileURL
        });
      });
    }
  }

  Future<void> updateLocation(Position position) async {
    print("Update Location");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot =
        await Firestore.instance.collection("users").document(user.uid).get();
    User userData = new User.fromMap(snapshot.data);
    String location = await _getAddressFromLatLng(position);
    Firestore.instance
        .collection("trucks")
        .document(userData.foodTruckId)
        .updateData({
      "latitude": position.latitude,
      "longitude": position.longitude,
      "location": location,
      "geoLocation": new GeoPoint(position.latitude, position.longitude)
    });
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];
      print("Name:" + place.name);
      print("Iso Country Code" + place.isoCountryCode);
      print("Country:" + place.country);
      print("Postal Code:" + place.postalCode);
      print("administrativeArea:" + place.administrativeArea);
      print("subAdministrativeArea:" + place.subAdministrativeArea);
      print("locality:" + place.locality);
      print("subLocality:" + place.subLocality);
      print("thoroughfare:" + place.thoroughfare);
      print("subThoroughfare:" + place.subThoroughfare);
      print("position:" + place.position.toString());
      return "${place.thoroughfare}, ${place.locality}";
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> loadTruckStream(String foodTruckID) async {
    DocumentReference reference =
        Firestore.instance.collection("trucks").document(foodTruckID);
    DocumentSnapshot snapshot = await reference.get();
    FoodTruck foodTruck = new FoodTruck.fromJson(snapshot.data);
    foodTruckStreamController.add(foodTruck);
    reference.snapshots().listen((event) {
      FoodTruck foodTruck = new FoodTruck.fromJson(event.data);
      foodTruckStreamController.add(foodTruck);
      this.foodTruck = foodTruck;
    });
  }

  Future<void> updateFoodTruck1(
      String name, String description, PickedFile file) async {
    if (file == null) {
      Firestore.instance.collection("trucks").document(foodTruckID).updateData({
        "foodTruckName": name,
        "description": description,
      });
    }
    else {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('foodTrucks' + foodTruckID);
      StorageUploadTask uploadTask = storageReference.putFile(File(file.path));
      await uploadTask.onComplete;
      print('File Uploaded');
      return storageReference.getDownloadURL().then((fileURL) async {
        await Firestore.instance
            .collection("trucks")
            .document(foodTruckID)
            .updateData({
          "foodTruckName": name,
          "description": description,
          "images": fileURL
        });
      });
    }
  }

  Future<void> updateLocationByOwner(String location) async {
    await Firestore.instance
        .collection("trucks")
        .document(foodTruckID)
        .updateData({"location": location});
  }

  Future<void> loadProfile() async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .get();
    User user = User.fromMap(snapshot.data);
    myProfileStreamController.add(user);
    Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .snapshots()
        .listen((event) {
      User user = User.fromMap(event.data);
      myProfileStreamController.add(user);
    });
  }

  Future<void> addItem(FoodItem foodItem) async {
    await Firestore.instance
        .collection("trucks")
        .document(foodTruckID)
        .collection("items")
        .add(foodItem.toJson());
  }

  Future<String> uploadImage(PickedFile file) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images').child(foodTruckID);
    StorageUploadTask uploadTask = storageReference.putFile(File(file.path));
    await uploadTask.onComplete;
    print('File Uploaded');
    return storageReference.getDownloadURL().then((fileURL) {
      return fileURL;
    });
  }

  Future<void> updateItem(
      FoodItem foodItem, String itemID, String truckID) async {
    await Firestore.instance
        .collection("trucks")
        .document(truckID)
        .collection("items")
        .document(itemID)
        .updateData(foodItem.toJson());
  }

  /*Future<void> updateFoodTruck(
      String name, String description, PickedFile file) async {
    if (file == null) {
      Firestore.instance.collection("trucks").document(foodTruckID).updateData({
        "foodTruckName": name,
        "description": description,
      });
    } else {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('foodTrucks' + foodTruckID);
      StorageUploadTask uploadTask = storageReference.putFile(File(file.path));
      await uploadTask.onComplete;
      print('File Uploaded');
      return storageReference.getDownloadURL().then((fileURL) async {
        await Firestore.instance
            .collection("trucks")
            .document(foodTruckID)
            .updateData({
          "foodTruckName": name,
          "description": description,
          "images": fileURL
        });
      });
    }
  }*/

  Future<void> updateProfilePic(PickedFile file) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profiles' + currentUser.phoneNumber);
    StorageUploadTask uploadTask = storageReference.putFile(File(file.path));
    await uploadTask.onComplete;
    print('File Uploaded');
    return storageReference.getDownloadURL().then((fileURL) async {
      await Firestore.instance
          .collection("users")
          .document(currentUser.uid)
          .updateData({"profilePicUrl": fileURL});
    });
  }
}
