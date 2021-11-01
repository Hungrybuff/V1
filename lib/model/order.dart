import 'package:hungrybuff/model/cart_model.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String orderId;
  String orderRef;
  String userId;
  Map<String, FoodCartItem> foodItemsInOrder = new Map();
  double totalCost;
  int time;
  int acceptedTime;
  int completedTime;
  int pickedTime;
  int cancelledTime;
  String coupon;
  double amountToPay;
  double discountAmount;
  String foodTruckID;
  int paymentMode;
  String orderType;
  int orderState;
  String rejectedReason;
  String suggestion;

  String getPaymentMode() {
    return paymentMode.toString();
  }

  Order(this.userId, this.foodItemsInOrder, this.totalCost, this.time,
      this.coupon, this.amountToPay, this.discountAmount, this.foodTruckID, this.orderRef);

  factory Order.fromJson(Map<String, dynamic> json) {
    //print("Food truck from " + json.toString());
    return _$OrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order.fromCart(Cart cart) {
    this.userId = cart.userId;
    this.foodItemsInOrder = cart.foodItemsInCart;
    this.totalCost = cart.totalCost;
    this.time = DateTime.now().millisecondsSinceEpoch;
    this.coupon = cart.coupon;
    this.amountToPay = cart.amountToPay;
    this.discountAmount = cart.discountAmount;
    this.foodTruckID = cart.foodTruckID;
    this.orderState = Constants.waitingForPayment;
    this.orderRef = null;
    this.orderType = "online";
  }

  @override
  String toString() {
    return 'Order{orderId: $orderId, orderRef: $orderRef, userId: $userId, foodItemsInOrder: $foodItemsInOrder, totalCost: $totalCost, time: $time, acceptedTime: $acceptedTime, completedTime: $completedTime, pickedTime: $pickedTime, cancelledTime: $cancelledTime, coupon: $coupon, amountToPay: $amountToPay, discountAmount: $discountAmount, foodTruckID: $foodTruckID, paymentMode: $paymentMode, orderType: $orderType, orderState: $orderState, rejectedReason: $rejectedReason, suggestion: $suggestion}';
  }
}
