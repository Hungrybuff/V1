// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return FoodItem(
    json['dishName'] as String,
    json['dishPic'] as String,
    (json['price'] as num)?.toDouble(),
    json['foodCategory'] as String,
    json['foodTruckID'] as String,
    json['itemID'] as String,
    json['spice'] as String,
    json['nuts'] as bool,
    json['tags'] as String,
    json['subTitle'] as String,
    json['description'] as String
  )..isAvailable = json['isAvailable'] as bool ?? false;
}

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
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
      'description': instance.description
    };
