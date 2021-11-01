// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    json['userId'] as String,
    (json['foodItemsInCart'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : FoodCartItem.fromJson(e as Map<String, dynamic>)),
    ),
    (json['totalCost'] as num)?.toDouble(),
    json['time'] as int,
    json['coupon'] as String,
    (json['amountToPay'] as num)?.toDouble(),
    (json['discountAmount'] as num)?.toDouble(),
    json['foodTruckID'] as String,
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'userId': instance.userId,
      'foodItemsInCart':
          instance.foodItemsInCart?.map((k, e) => MapEntry(k, e?.toJson())),
      'totalCost': instance.totalCost,
      'time': instance.time,
      'coupon': instance.coupon,
      'amountToPay': instance.amountToPay,
      'discountAmount': instance.discountAmount,
      'foodTruckID': instance.foodTruckID,
    };
