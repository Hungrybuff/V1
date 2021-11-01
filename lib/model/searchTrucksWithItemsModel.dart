import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/model/food_truck.dart';

class FoodTruckWithItems {
  FoodTruck foodTruck;
  List<FoodItem> menuItemsList;

  FoodTruckWithItems({this.foodTruck, this.menuItemsList});

  @override
  String toString() {
    return 'FoodTruckWithItems{foodTruck: $foodTruck, menuItemsList: $menuItemsList}';
  }
}
