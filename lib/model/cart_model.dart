import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  String userId;
  Map<String, FoodCartItem> foodItemsInCart = new Map();
  double totalCost;
  int time;
  String coupon;
  double amountToPay;
  double discountAmount;
  String foodTruckID;

  Cart(this.userId, this.foodItemsInCart, this.totalCost, this.time,
      this.coupon, this.amountToPay, this.discountAmount, this.foodTruckID);

  factory Cart.fromJson(Map<String, dynamic> json) {
    //print("Food truck from " + json.toString());
    return _$CartFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartToJson(this);

  Cart.newOrder(FoodCartItem foodItem, String userId) {
    foodItem.quantity = 1;
    this.foodTruckID = foodItem.foodTruckID;
    this.userId = userId;
    this.time = DateTime.now().millisecondsSinceEpoch;
    this.foodItemsInCart = new Map();
    foodItemsInCart[foodItem.itemID] = foodItem;
    totalCost = foodItem.price * foodItem.quantity;
    amountToPay = totalCost;
    discountAmount = 0;
    coupon = null;
  }
}
