// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('BaseModel', json, () {
    $checkKeys(json, allowedKeys: const ['is_error', 'error']);
    final val = BaseModel();
    $checkedConvert(json, 'is_error', (v) => val.isError = v as bool ?? false);
    $checkedConvert(json, 'error', (v) => val.error = v as String ?? '');
    return val;
  }, fieldKeyMap: const {'isError': 'is_error'});
}

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'is_error': instance.isError,
      'error': instance.error,
    };
