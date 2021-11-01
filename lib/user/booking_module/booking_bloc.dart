import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hungrybuff/model/cart_model.dart';
import 'package:hungrybuff/model/feedbackModel.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:rxdart/rxdart.dart';

class BookingBloc {
  FirebaseUser _firebaseUser;
  Cart _cart;
  Order _order;

  final BehaviorSubject<Cart> foodItemsInCartController =
      new BehaviorSubject<Cart>();

  static BookingBloc _instance;

  Stream<Cart> get foodItemsStream => foodItemsInCartController.stream;

  BookingBloc() {
    init();
  }

  FirebaseUser get getFirebaseUser => _firebaseUser;

  String get getAmountTobePaid => _order.amountToPay.toString();

  Future init() async {
    print("Init new Booking bloc");
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection("cart")
        .document(this._firebaseUser.uid)
        .snapshots()
        .listen(onCartUpdated);
    foodItemsInCartController.add(_cart);
  }

  void close() {
    foodItemsInCartController.close();
  }

  Future<void> onCartUpdated(DocumentSnapshot event) async {
    if (event.exists) {
      print("event.exists");
      event.data["userId"] = event.documentID;
      _cart = Cart.fromJson(event.data);
      if (_cart.foodItemsInCart == null || _cart.foodItemsInCart.length == 0)
        await deleteUserCart();
    } else
      _cart = null;
    foodItemsInCartController.add(_cart);
  }

  Future<void> increaseQuantityByOne(FoodItem foodItem) async {
    print("Increasing quantity of " + foodItem.toString());
    if (_cart == null)
      _cart = Cart.newOrder(foodItem, _firebaseUser.uid);
    else if (foodItem.foodTruckID != _cart.foodTruckID) {
      await deleteUserCart();
      _cart = Cart.newOrder(foodItem, _firebaseUser.uid);
    } else {
      if (!_cart.foodItemsInCart.containsKey(foodItem.itemID))
        _cart.foodItemsInCart[foodItem.itemID] = foodItem;
      _cart.foodItemsInCart[foodItem.itemID].quantity += 1;
      _cart.totalCost += foodItem.price;
    }
    _cart.amountToPay = _cart.totalCost;
    return await updateCart(_cart);
  }

  Future<void> decreaseQuantityByOne(FoodItem foodItem) async {
    if (_cart == null ||
        _cart.foodItemsInCart == null ||
        _cart.foodItemsInCart.length == 0) return deleteUserCart();
    _cart.foodItemsInCart[foodItem.itemID].quantity -= 1;
    if (_cart.foodItemsInCart[foodItem.itemID].quantity < 1)
      _cart.foodItemsInCart.remove(foodItem.itemID);
    _cart.totalCost -= foodItem.price;
    if (_cart.foodItemsInCart.length < 1) return deleteUserCart();
    if (_cart == null ||
        _cart.foodItemsInCart == null ||
        _cart.foodItemsInCart.length == 0) return deleteUserCart();
    _cart.amountToPay = _cart.totalCost;
    return updateCart(_cart);
  }

  static BookingBloc getInstance() {
    print("Returning booking bloc instance");
    if (_instance == null) _instance = new BookingBloc();
    return _instance;
  }

  Future<void> updateFoodTruckId(FoodItem foodItem) async {
    print("food Item is :" + foodItem.itemID);
    await Firestore.instance
        .collection("trucks")
        .document(foodItem.foodTruckID)
        .collection("items")
        .document(foodItem.itemID)
        .updateData(foodItem.toJson());
  }

  Future<void> deleteUserCart() async {
    print("delete user cart in bookin bloc");
    return await Firestore.instance
        .collection("cart")
        .document(this._firebaseUser.uid)
        .delete();
  }

  Future<void> updateCart(Cart cart) async {
    print("firebase user id:" + this._firebaseUser.uid);
    return await Firestore.instance
        .collection("cart")
        .document(this._firebaseUser.uid)
        .setData(cart.toJson());
  }

  Future<Order> proceedToBuy(String comments) async {
    _order = Order.fromCart(_cart);
    _order.suggestion = comments;
    DocumentReference documentReference =
        await Firestore.instance.collection("orders").add(_order.toJson());
    _order.orderId = documentReference.documentID;
    _order.orderRef = documentReference.documentID.substring(0,4).toUpperCase();

    await Firestore.instance
        .collection("orders")
        .document(_order.orderId)
        .updateData(_order.toJson());
    //create transaction ID
    return _order;
  }

  Future<void> confirmPaymentWithCash() async {
    await deleteUserCart();
    _order.orderState = Constants.waitingToBeAccepted;
    _order.paymentMode = Constants.cashPaymentMode;
    return await Firestore.instance
        .collection("orders")
        .document(_order.orderId)
        .updateData(_order.toJson());
  }

  Future<void> confirmPaymentWithCard() async {
    await deleteUserCart();
    _order.orderState = Constants.waitingToBeAccepted;
    _order.paymentMode = Constants.cardPaymentMode;
    return await Firestore.instance
        .collection("orders")
        .document(_order.orderId)
        .updateData(_order.toJson());
  }

  Future<void> confirmPaymentWithGPay() async {
    await deleteUserCart();
    _order.orderState = Constants.waitingToBeAccepted;
    _order.paymentMode = Constants.gPayPaymentMode;
    return await Firestore.instance
        .collection("orders")
        .document(_order.orderId)
        .updateData(_order.toJson());
  }

  Future<void> cancelOrder(Order order) async {
    print("cance order called with order id" + order.orderId);
    order.orderState = Constants.cancelled;
    return await Firestore.instance
        .collection("orders")
        .document(order.orderId)
        .updateData(order.toJson());
  }

  Future<void> sendFeedBack(
      FoodTruck foodTruck, FeedBackModel feedBackModel) async {
    await Firestore.instance
        .collection("trucks")
        .document(foodTruck.foodTruckId)
        .collection("feedbacks")
        .document(_firebaseUser.phoneNumber)
        .setData({
      "rating": feedBackModel.ratings,
      "comments": feedBackModel.comments
    });
  }
}
