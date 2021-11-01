import 'package:json_annotation/json_annotation.dart';

part 'food_truck.g.dart';

@JsonSerializable()
class FoodTruck {
  String foodTruckName;
  String location;
  double rating;
  String deliveryTime;
  bool isOpen;
  bool preBooking;
  String isMyFavourite;
  String images;
  String favourite;
  String description;

  String foodTruckId;

  double fromTime;
  double toTime;
  List<String> subTitles;

  FoodTruck(
      this.foodTruckName,
      this.location,
      this.rating,
      this.deliveryTime,
      this.isOpen,
      this.preBooking,
      this.isMyFavourite,
      this.images,
      this.favourite,
      this.description,
      this.foodTruckId,
      this.fromTime,
      this.toTime,
      this.subTitles); //  String foodTruckName;
//  String location;
//  double rating;
//  double fromTime;
//  double toTime;
//  bool isOpen;
//  bool preBooking;
//  String images;
//  String foodTruckId;
//  String description;

  factory FoodTruck.fromJson(Map<String, dynamic> json) {
    //print("Food truck from " + json.toString());
    return _$FoodTruckFromJson(json);
  }


  @override
  String toString() {
    return 'FoodTruck{foodTruckName: $foodTruckName, location: $location, rating: $rating, deliveryTime: $deliveryTime, isOpen: $isOpen, preBooking: $preBooking, isMyFavourite: $isMyFavourite, images: $images, favourite: $favourite, description: $description, foodTruckId: $foodTruckId, fromTime: $fromTime, toTime: $toTime, subTitles: $subTitles}';
  }

  Map<String, dynamic> toJson() => _$FoodTruckToJson(this);
}

class NearByTrucksConverter {
  List<FoodTruck> nearByTrucks;

  NearByTrucksConverter({this.nearByTrucks});

  NearByTrucksConverter.fromJson(Map<String, dynamic> json) {
    if (json['NearByTrucks'] != null) {
      nearByTrucks = new List<FoodTruck>();
      json['NearByTrucks'].forEach((v) {
        nearByTrucks.add(new FoodTruck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearByTrucks != null) {
      data['NearByTrucks'] = this.nearByTrucks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FamousTrucksConverter {
  List<FoodTruck> famousTrucks;

  FamousTrucksConverter({this.famousTrucks});

  FamousTrucksConverter.fromJson(Map<String, dynamic> json) {
    if (json['FamousTrucks'] != null) {
      famousTrucks = new List<FoodTruck>();
      json['FamousTrucks'].forEach((v) {
        famousTrucks.add(new FoodTruck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.famousTrucks != null) {
      data['FamousTrucks'] = this.famousTrucks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DummyTrucks {
  List<FoodTruck> list = new List();

  List<FoodTruck> getSourceList() {
    list.clear();
    return list;
  }
}

class FoodTruckDecoder {
  List<FoodTruck> results;

  FoodTruckDecoder({this.results});

  FoodTruckDecoder.fromJson(dynamic json) {
//    print("from json called with json = " + json.toString());
    if (json['results'] != null) {
      print("json[reslts] ! = null");
      results = new List<FoodTruck>();
      json['results'].forEach((v) {
        print("inside for each");
        results.add(new FoodTruck.fromJson(v));
      });
    } else {
      print("json [results] == null");
    }
  }
}
