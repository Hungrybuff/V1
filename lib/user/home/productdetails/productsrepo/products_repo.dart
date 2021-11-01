import 'package:hungrybuff/model/food_truck.dart';

class ProductsRepo {
  static ProductsRepo _instance;

  ProductsRepo._internal();

  static ProductsRepo getInstance() {
    if (_instance == null) _instance = ProductsRepo._internal();
    return _instance;
  }

  List<FoodTruck> getList() {
    //todo
  }
}
