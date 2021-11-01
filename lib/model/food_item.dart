import 'package:json_annotation/json_annotation.dart';

part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  String dishName;
  String dishPic;
  double price;
  @JsonKey(defaultValue: false)
  String foodCategory;//veg,vegan,non-veg
  String foodTruckID;
  String itemID;
  String spice;
  String description;
  bool nuts;
  String tags;
  String subTitle;
  @JsonKey(defaultValue: false)
  bool isAvailable;
  bool isVeg;





  FoodItem(
      this.dishName,
      this.dishPic,
      this.price,
      this.foodCategory,
      this.foodTruckID,
      this.itemID,
      this.spice,
      this.nuts,
      this.tags,this.subTitle, this.description);


  @override
  String toString() {
    return 'FoodItem{dishName: $dishName, dishPic: $dishPic, price: $price, foodCategory: $foodCategory, foodTruckID: $foodTruckID, itemID: $itemID, spice: $spice, nuts: $nuts, tags: $tags, subTitle: $subTitle, description: $description, isAvailable: $isAvailable}';
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    print("Trying to convert this map to :" + json.toString());
    json["price"] = double.parse(json["price"].toString());
    return _$FoodItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}
