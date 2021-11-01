import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hungrybuff/model/event_model.dart';

import 'event_dummy_source.dart';

class Repo {
  APISource apiSource = APISource.getInstance();
  DummySource dummy = new DummySource();

  Future<List<Event>> getList() async {
    return await apiSource.getEvents();
  }
}

class APISource {
  static APISource _instance;

  static APISource getInstance() {
    if (_instance == null) _instance = new APISource();
    return _instance;
  }

  Future<List<Event>> getEvents() async {
    print("Fetch called");
    final response = await http.get(
        'https://us-central1-chatdemo-24605.cloudfunctions.net/returnEventsTest2');

    if (response.statusCode == 200) {
      print("response");
      final EventsList eventsList =
          EventsList.fromJson(jsonDecode(response.body));
      print(eventsList.toString());

      return eventsList.eventsDetails;
      // If server returns an OK response, parse the JSON.
//        return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class EventsList {
  List<Event> eventsDetails;

  EventsList({this.eventsDetails});

  EventsList.fromJson(Map<String, dynamic> json) {
    if (json['eventsDetails'] != null) {
      eventsDetails = new List<Event>();
      json['eventsDetails'].forEach((v) {
        eventsDetails.add(new Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventsDetails != null) {
      data['eventsDetails'] =
          this.eventsDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
