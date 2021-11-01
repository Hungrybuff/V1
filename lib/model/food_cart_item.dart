import 'package:hungrybuff/model/food_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_cart_item.g.dart';

@JsonSerializable()
class FoodCartItem extends FoodItem {
  @JsonKey(defaultValue: 0)
  int quantity;

  @override
  FoodCartItem(this.quantity, String dishName, String dishPic, double price,
       String foodTruckID, String itemID,String tags,String foodCategory,String spice,bool nuts,String subTitle, String description)
      : super(dishName,
      dishPic,
      price,
      foodCategory,
      foodTruckID,
      itemID,
      spice,
      nuts,
      tags,subTitle, description);

  factory FoodCartItem.fromJson(Map<String, dynamic> json) {
    print("Trying to convert this map to :" + json.toString());
    json["price"] = double.parse(json["price"].toString());
    return _$FoodCartItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FoodCartItemToJson(this);
}
