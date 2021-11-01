// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    json['get'] as String,
    json['code'] as String,
    json['bottomDesc'] as String,
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'get': instance.get,
      'code': instance.code,
      'bottomDesc': instance.bottomDesc,
    };
