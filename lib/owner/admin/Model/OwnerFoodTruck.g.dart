// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OwnerFoodTruck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerFoodTruck _$OwnerFoodTruckFromJson(Map<String, dynamic> json) {
  return OwnerFoodTruck(
    json['foodTruckName'] as String,
    json['location'] as String ?? 'Some location',
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
    json['ownerId'] as String,
    (json['subTitles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OwnerFoodTruckToJson(OwnerFoodTruck instance) =>
    <String, dynamic>{
      'foodTruckName': instance.foodTruckName,
      'location': instance.location,
      'rating': instance.rating,
      'deliveryTime': instance.deliveryTime,
      'isOpen': instance.isOpen,
      'preBooking': instance.preBooking,
      'isMyFavourite': instance.isMyFavourite,
      'favourite': instance.favourite,
      'description': instance.description,
      'foodTruckId': instance.foodTruckId,
      'images': instance.images,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
      'subTitles': instance.subTitles,
      'ownerId': instance.ownerId,
    };
