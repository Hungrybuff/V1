// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_truck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodTruck _$FoodTruckFromJson(Map<String, dynamic> json) {
  return FoodTruck(
    json['foodTruckName'] as String,
    json['location'] as String,
    (json['rating'] as num)?.toDouble(),
    json['deliveryTime'] as String,
    json['isOpen'] as bool,
    json['preBooking'] as bool,
    json['isMyFavourite'] as String,
    json['images'] as String,
    json['favourite'] as String,
    json['description'] as String,
    json['foodTruckId'] as String,
    (json['fromTime'] as num)?.toDouble(),
    (json['toTime'] as num)?.toDouble(),
    (json['subTitles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FoodTruckToJson(FoodTruck instance) => <String, dynamic>{
      'foodTruckName': instance.foodTruckName,
      'location': instance.location,
      'rating': instance.rating,
      'deliveryTime': instance.deliveryTime,
      'isOpen': instance.isOpen,
      'preBooking': instance.preBooking,
      'isMyFavourite': instance.isMyFavourite,
      'images': instance.images,
      'favourite': instance.favourite,
      'description': instance.description,
      'foodTruckId': instance.foodTruckId,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
      'subTitles': instance.subTitles,
    };
