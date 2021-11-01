import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hungrybuff/model/event_model.dart';
import 'package:hungrybuff/model/food_truck.dart';

class HomeRepo {
  static HomeRepo _instance;

  HomeRepo._internal();

  static HomeRepo getInstance() {
    if (_instance == null) _instance = HomeRepo._internal();
    return _instance;
  }

  // NearbyTrucks Api call
  Future<List<FoodTruck>> getList() async {
    return NearbySource().getnTruckData();
  }

  Future<List<FoodTruck>> getFList() async {
    return FamousSource().getFamousData();
  }

  Future<List<Event>> getEList() async {
    return HomeEventsSource().getHomeEventsData();
  }
}

class FamousSource {
  Future<List<FoodTruck>> getFamousData() async {
    var response = await http.get(
        'https://us-central1-chatdemo-24605.cloudfunctions.net/returnExploreFamousTest2');

    List<FoodTruck> fTrucks;

    fTrucks =
        FamousTrucksConverter.fromJson(jsonDecode(response.body)).famousTrucks;

    return fTrucks;
  }
}

class NearbySource {
  Future<List<FoodTruck>> getnTruckData() async {
    var response = await http.get(
        'https://us-central1-chatdemo-24605.cloudfunctions.net/returnExploreNearTest2');

    List<FoodTruck> trucks;

    trucks =
        NearByTrucksConverter.fromJson(jsonDecode(response.body)).nearByTrucks;

    return trucks;
  }
}

class HomeEventsSource {
  Future<List<Event>> getHomeEventsData() async {
    var response = await http.get(
        'https://us-central1-chatdemo-24605.cloudfunctions.net/returnExploreEventsTest2');

    List<Event> eEvents;

    eEvents =
        HomeEventsConverter.fromJson(jsonDecode(response.body)).exploreEvents;

    return eEvents;
  }
}
