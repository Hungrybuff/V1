// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    name: json['name'] as String,
    location: json['location'] as String,
    day: json['day'] as String,
    date: json['date'] as String,
    timings: json['timings'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'day': instance.day,
      'date': instance.date,
      'timings': instance.timings,
      'image': instance.image,
    };
