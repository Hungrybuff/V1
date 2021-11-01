// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodCartItem _$FoodCartItemFromJson(Map<String, dynamic> json) {
  return FoodCartItem(
    json['quantity'] as int ?? 0,
    json['dishName'] as String,
    json['dishPic'] as String,
    (json['price'] as num)?.toDouble(),
    json['foodTruckID'] as String,
    json['itemID'] as String,
    json['tags'] as String,
    json['foodCategory'] as String,
    json['spice'] as String,
    json['nuts'] as bool,
    json['subTitle'] as String,
    json['description'] as String,
  )..isAvailable = json['isAvailable'] as bool ?? false;
}

Map<String, dynamic> _$FoodCartItemToJson(FoodCartItem instance) =>
    <String, dynamic>{
      'dishName': instance.dishName,
      'dishPic': instance.dishPic,
      'price': instance.price,
      'foodCategory': instance.foodCategory,
      'foodTruckID': instance.foodTruckID,
      'itemID': instance.itemID,
      'spice': instance.spice,
      'nuts': instance.nuts,
      'tags': instance.tags,
      'subTitle': instance.subTitle,
      'isAvailable': instance.isAvailable,
      'quantity': instance.quantity,
      'description': instance.description
    };
