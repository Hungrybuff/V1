import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungrybuff/model/order.dart';

class OrderDetailsBloc {
  static OrderDetailsBloc _instance;

  static OrderDetailsBloc getInstance() {
    if (_instance == null) _instance = new OrderDetailsBloc();
    return _instance;
  }


  Future<DocumentSnapshot> getUsersDetails(Order order) async {
    return await Firestore.instance
        .collection("users")
        .document(order.userId)
        .get();
  }

  Future<DocumentSnapshot> getTruckDetails(Order order) async {
    return await Firestore.instance
        .collection("trucks")
        .document(order.foodTruckID)
        .get();
  }

  Stream<QuerySnapshot> getStreamForOrderProcess(Order order) {
    return Firestore.instance
        .collection("orders")
        .where("orderId", isEqualTo: order.orderId).snapshots();
  }


}
