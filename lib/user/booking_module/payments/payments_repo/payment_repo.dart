import 'package:hungrybuff/model/payment_model.dart';
import 'package:hungrybuff/user/Booking_Module/payments/payments_repo/payment_modes.dart';

class PaymentRepo {
  static PaymentRepo _instance;

  PaymentRepo._internal();

  static PaymentRepo getInstance() {
    if (_instance == null) _instance = PaymentRepo._internal();
    return _instance;
  }

  PaymentModes pModes = new PaymentModes();

  List<Payment> getList() {
    return pModes.getList();
  }
}
