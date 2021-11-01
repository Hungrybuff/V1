// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_screen_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashScreenData _$SplashScreenDataFromJson(Map<String, dynamic> json) {
  return SplashScreenData(
    didUserGiveAllTheDetials: json['didUserGiveAllTheDetials'] as bool,
    isUserValidUser: json['isUserValidUser'] as bool,
  )
    ..isError = json['isError'] as bool ?? false
    ..error = json['error'] as String ?? '';
}

Map<String, dynamic> _$SplashScreenDataToJson(SplashScreenData instance) =>
    <String, dynamic>{
      'isError': instance.isError,
      'error': instance.error,
      'didUserGiveAllTheDetials': instance.didUserGiveAllTheDetials,
      'isUserValidUser': instance.isUserValidUser,
    };
