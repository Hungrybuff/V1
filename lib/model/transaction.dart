//import 'package:json_annotation/json_annotation.dart';
//
//part 'transaction.g.dart';
//
//@JsonSerializable(explicitToJson: true)
//class Transaction {
//  String orderId;
//  String userId;
//  int time;
//  double amountToPay;
//  String foodTruckID;
//  String paymentMode;
//  String orderType;
//  int orderState;
//  String rejectedReason;
//
//  Transaction(this.userId, this.foodItemsInOrder, this.totalCost, this.time,
//      this.coupon, this.amountToPay, this.discountAmount, this.foodTruckID);
//
//  factory Transaction.fromJson(Map<String, dynamic> json) {
//    print("Food truck from " + json.toString());
//    return _$TransactionFromJson(json);
//  }
//
//  Map<String, dynamic> toJson() => _$TransactionToJson(this);
//
////  Transaction.fromCart(CarOdet cart) {
////    this.userId = cart.userId;
////    this.foodItemsInOrder = cart.foodItemsInCart;
////    this.totalCost = cart.totalCost;
////    this.time = DateTime.now().millisecondsSinceEpoch;
////    this.coupon = cart.coupon;
////    this.amountToPay = cart.amountToPay;
////    this.discountAmount = cart.discountAmount;
////    this.foodTruckID = cart.foodTruckID;
////    this.orderState = Constants.waitingForPayment;
////    this.orderType = "online";
////  }
//}
