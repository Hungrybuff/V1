import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/HomeModule/repo/ordersRepo.dart';
import 'package:hungrybuff/owner/HomeModule/ui/new_orders_tab.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc {
  static OrdersBloc _instance;
  OrdersRepo noRepo = OrdersRepo.getInstance();
  ReasonRepo repo = new ReasonRepo();
  OwnerHomeBloc _homeBloc = OwnerHomeBloc.getInstance();

  final rejectController = new BehaviorSubject<List<ReasonModel>>();
  Stream<List<ReasonModel>> get rejectStream => rejectController.stream;

  static OrdersBloc getInstance() {
    if (_instance == null) _instance = new OrdersBloc();
    return _instance;
  }

  OrdersBloc(){
    rejectController.stream.listen(listen);
  }

  List<Order> getList() {
    return noRepo.getList();
  }

  Future<void> acceptOrder(Order order) async {
    order.orderState = Constants.accepted;
    await Firestore.instance
        .collection("orders")
        .document(order.orderId)
        .updateData(order.toJson());
  }

  Future<void> rejectOrder(Order order, {String rejectedReason}) async {
    print("order reject");
    order.orderState = Constants.cancelled;
    order.rejectedReason=rejectedReason==null?"":rejectedReason;
    await Firestore.instance
        .collection("orders")
        .document(order.orderId)
        .updateData(order.toJson());
  }

  Future<Stream<QuerySnapshot>> getNewOrdersStream() async {
    print("new orders stream");
    /*if (_homeBloc == null || _homeBloc.foodTruck == null)
      await _homeBloc.init();
    */

    return query();
  }

  Stream<QuerySnapshot> query() {
    return Firestore.instance
      .collection("orders")
      .where("foodTruckID", isEqualTo:_homeBloc.foodTruckID)
      .where("orderState", isEqualTo: Constants.waitingToBeAccepted)
      .orderBy("time")
      .snapshots();
  }

  Future<Stream<QuerySnapshot>> getAcceptedOrdersStream() async {
    if (_homeBloc == null || _homeBloc.foodTruck == null)
      await _homeBloc.init();

    return Firestore.instance
        .collection("orders")
        .where("foodTruckID", isEqualTo: _homeBloc.foodTruckID)
        .where("orderState", isEqualTo: Constants.accepted)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getCompletedOrdersStream() async {
    if (_homeBloc == null || _homeBloc.foodTruck == null)
      await _homeBloc.init();

    return Firestore.instance
        .collection("orders")
        .where("foodTruckID", isEqualTo: _homeBloc.foodTruckID)
        .where("orderState", isEqualTo: Constants.finishedOrder)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getRejectedOrdersStream() async {
    if (_homeBloc == null || _homeBloc.foodTruck == null)
      await _homeBloc.init();

    return Firestore.instance
        .collection("orders")
        .where("foodTruckID", isEqualTo: _homeBloc.foodTruckID)
        .where("orderState", isEqualTo: Constants.cancelled)
        .snapshots();
  }

  Future<void> markOrderAsReadyToBePicked(Order order) async {
    order.orderState = Constants.readyToBePicked;
    order.completedTime = DateTime.now().millisecondsSinceEpoch;
    await Firestore.instance
        .collection("orders")
        .document(order.orderId)
        .updateData(order.toJson());
  }

  Future<void> markOrderAsPicked(Order order) async {
    order.orderState = Constants.finishedOrder;
    order.pickedTime = DateTime.now().millisecondsSinceEpoch;
    await Firestore.instance
        .collection("orders")
        .document(order.orderId)
        .updateData(order.toJson());
  }

  void listen(List<ReasonModel> event) {

    event=repo.getList();
  }
}
