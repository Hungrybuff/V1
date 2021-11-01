import 'package:hungrybuff/model/coupons_model.dart';
import 'package:hungrybuff/user/Booking_Module/cartScreen/cart_repo/coupons_repo.dart';

class CouponsBloc {
  static CouponsBloc _instance;

  CouponsRepo couRepo;

  static CouponsBloc getInstance() {
    if (_instance == null) _instance = CouponsBloc._internal();
    return _instance;
  }

  CouponsBloc._internal() {
    couRepo = CouponsRepo.getInstance();
  }

  List<Coupon> getList() {
    return couRepo.getList();
  }
}
