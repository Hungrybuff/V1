import 'package:hungrybuff/model/payment_model.dart';
import 'package:hungrybuff/user/Booking_Module/payments/payments_repo/payment_repo.dart';

class PaymentBloc {
  static PaymentBloc _instance;

  PaymentRepo pRepo;

  static PaymentBloc getInstance() {
    if (_instance == null) _instance = PaymentBloc._internal();
    return _instance;
  }

  PaymentBloc._internal() {
    pRepo = PaymentRepo.getInstance();
  }

  List<Payment> getList() {
    return pRepo.getList();
  }
}
