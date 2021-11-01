// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['userId'] as String,
    (json['foodItemsInOrder'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : FoodCartItem.fromJson(e as Map<String, dynamic>)),
    ),
    (json['totalCost'] as num)?.toDouble(),
    json['time'] as int,
    json['coupon'] as String,
    (json['amountToPay'] as num)?.toDouble(),
    (json['discountAmount'] as num)?.toDouble(),
    json['foodTruckID'] as String,
    json['orderRef'] as String,
  )
    ..orderId = json['orderId'] as String
    ..orderRef = json['orderRef'] as String
    ..acceptedTime = json['acceptedTime'] as int
    ..completedTime = json['completedTime'] as int
    ..pickedTime = json['pickedTime'] as int
    ..cancelledTime = json['cancelledTime'] as int
    ..paymentMode = json['paymentMode'] as int
    ..orderType = json['orderType'] as String
    ..orderState = json['orderState'] as int
    ..rejectedReason = json['rejectedReason'] as String
    ..suggestion = json['suggestion'] as String;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'orderRef': instance.orderRef,
      'userId': instance.userId,
      'foodItemsInOrder':
          instance.foodItemsInOrder?.map((k, e) => MapEntry(k, e?.toJson())),
      'totalCost': instance.totalCost,
      'time': instance.time,
      'acceptedTime': instance.acceptedTime,
      'completedTime': instance.completedTime,
      'pickedTime': instance.pickedTime,
      'cancelledTime': instance.cancelledTime,
      'coupon': instance.coupon,
      'amountToPay': instance.amountToPay,
      'discountAmount': instance.discountAmount,
      'foodTruckID': instance.foodTruckID,
      'paymentMode': instance.paymentMode,
      'orderType': instance.orderType,
      'orderState': instance.orderState,
      'rejectedReason': instance.rejectedReason,
      'suggestion': instance.suggestion,
    };
