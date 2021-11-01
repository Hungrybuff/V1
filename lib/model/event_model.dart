import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class Event {
  String name;
  String location;
  String day;
  String date;
  String timings;
  String image;

  Event(
      {this.name,
      this.location,
      this.day,
      this.date,
      this.timings,
      this.image});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

class HomeEventsConverter {
  List<Event> exploreEvents;

  HomeEventsConverter({this.exploreEvents});

  HomeEventsConverter.fromJson(Map<String, dynamic> json) {
    if (json['exploreEvents'] != null) {
      exploreEvents = new List<Event>();
      json['exploreEvents'].forEach((v) {
        exploreEvents.add(new Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exploreEvents != null) {
      data['exploreEvents'] =
          this.exploreEvents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
