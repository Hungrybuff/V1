import 'package:json_annotation/json_annotation.dart';
import 'package:hungrybuff/model/food_truck.dart';

part 'OwnerFoodTruck.g.dart';

@JsonSerializable()
class OwnerFoodTruck extends FoodTruck {
  String ownerId;

  OwnerFoodTruck(
      String foodTruckName,
      String location,
      double rating,
      String deliveryTime,
      bool isOpen,
      bool preBooking,
      String isMyFavourite,
      String images,
      String favourite,
      String description,
      String foodTruckId,
      double fromTime,
      double toTime,
      this.ownerId,
      List<String> subTitles)
      : super(
            foodTruckName,
            location,
            rating,
            deliveryTime,
            isOpen,
            preBooking,
            isMyFavourite,
            images,
            favourite,
            description,
            foodTruckId,
            fromTime,
            toTime,
            subTitles
  );

  factory OwnerFoodTruck.fromJson(Map<String, dynamic> json) =>
      _$OwnerFoodTruckFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerFoodTruckToJson(this);
}
