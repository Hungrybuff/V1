import 'package:hungrybuff/model/order.dart';

class OrdersRepo {
  static OrdersRepo _instance;

  static OrdersRepo getInstance() {
    if (_instance == null) _instance = OrdersRepo._create();

    return _instance;
  }

  OrdersRepo._create();

  List<Order> getList() {
    return new List();
  }
}
