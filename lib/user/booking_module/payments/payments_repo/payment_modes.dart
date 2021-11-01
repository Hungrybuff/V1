import 'package:hungrybuff/model/payment_model.dart';

class PaymentModes {
  List<Payment> plist = new List();

  Payment pModel3 =
      new Payment('assets/payments/cash.png', "Pay With Cash", true);

  List<Payment> getList() {
    plist.clear();
    plist.add(pModel3);
    return plist;
  }
}
