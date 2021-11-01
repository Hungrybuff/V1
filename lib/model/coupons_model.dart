import 'package:json_annotation/json_annotation.dart';

part 'coupons_model.g.dart';

@JsonSerializable()
class Coupon {
  String get;
  String code;
  String bottomDesc;

  Coupon(this.get, this.code, this.bottomDesc);

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}

class DummyCoupons {
  List<Coupon> list = List();

  Coupon coup1 = new Coupon("Get Rs.50 off", "HUNG50",
      "Get Rs.50 off on purchase of Rs.200 and above");
  Coupon coup2 = new Coupon("Get Rs.10% off", "HUNG10",
      "Get Rs.50 off on purchase of Rs.200 and above");
  Coupon coup3 = new Coupon("Get Rs.50% off", "HUNGHALF",
      "Get Rs.50 off on purchase of Rs.200 and above");
  Coupon coup4 = new Coupon("Get Rs.30 off", "HUNG30",
      "Get Rs.50 off on purchase of Rs.200 and above");
  Coupon coup5 = new Coupon("Get Rs.100 off", "HUNG100",
      "Get Rs.50 off on purchase of Rs.200 and above");

  List<Coupon> getList() {
    list.clear();
    list.add(coup1);
    list.add(coup2);
    list.add(coup3);
    list.add(coup4);
    list.add(coup5);
    return list;
  }
}
