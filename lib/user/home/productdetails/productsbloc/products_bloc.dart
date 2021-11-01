import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/user/home/productdetails/productsrepo/products_repo.dart';

class ProductsBloc {
  static ProductsBloc _instance;

  ProductsRepo pRepo;

  static ProductsBloc getInstance() {
    if (_instance = null) _instance = ProductsBloc._internal();
    return _instance;
  }

  ProductsBloc._internal() {
    pRepo = ProductsRepo.getInstance();
  }

  List<FoodTruck> getList() {
    return pRepo.getList();
  }
}
