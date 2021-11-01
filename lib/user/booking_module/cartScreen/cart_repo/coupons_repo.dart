import 'package:hungrybuff/model/coupons_model.dart';

class CouponsRepo {
  static CouponsRepo _instance;

  static CouponsRepo getInstance() {
    if (_instance == null) _instance = CouponsRepo._internal();
    return _instance;
  }

  CouponsRepo._internal() {}

  DummyCoupons dumCop = DummyCoupons();

  List<Coupon> getList() {
    return dumCop.getList();
  }
}

class BeforeCoupon {
  List<FoodInCart> foodInCart;

  BeforeCoupon({this.foodInCart});

  BeforeCoupon.fromJson(Map<String, dynamic> json) {
    if (json['Food in cart'] != null) {
      foodInCart = new List<FoodInCart>();
      json['Food in cart'].forEach((v) {
        foodInCart.add(new FoodInCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodInCart != null) {
      data['Food in cart'] = this.foodInCart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodInCart {
  String name;
  String amount;
  String quantity;
  String image;
  String total;

  FoodInCart({this.name, this.amount, this.quantity, this.image, this.total});

  FoodInCart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    quantity = json['quantity'];
    image = json['image'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    data['total'] = this.total;
    return data;
  }
}
