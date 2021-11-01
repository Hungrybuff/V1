import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/cart_model.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/model/payment_model.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/user/authentication/ui/acc_created.dart';
import 'package:hungrybuff/user/booking_module/booking_bloc.dart';
import 'package:hungrybuff/user/booking_module/payments/payments_bloc/payment_bloc.dart';
import 'package:hungrybuff/user/booking_module/payments/payments_repo/payment_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PaymentOptions extends StatefulWidget {
  PaymentOptions(this.order);

  final Order order;

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  BookingBloc bookingBloc = BookingBloc.getInstance();

  UtilColors uCol = new UtilColors();

  List<Payment> paymentsList = PaymentBloc.getInstance().getList();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String _error;
  PaymentType paymentType = PaymentType.cash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: appbarStyle,
        ),
      ),
      body: getDifferentPaymentsOptionsColumn(),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  Widget buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 56.4,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [uCol.gradient2, uCol.gradient1]),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () async {
              await onBottomAppBarPressed(context);
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllOrdersScreen(bookingBloc.getFirebaseUser)));*/
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "PAY NOW",
                  style: buttonStyle,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      bookingBloc.getAmountTobePaid + "£",
                      style: buttonStyle,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future onBottomAppBarPressed(BuildContext context) async {
    print("payent type is" + paymentType.toString());
    switch (paymentType) {
      case PaymentType.cash:
        await bookingBloc.confirmPaymentWithCash();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OrderCreated(getFirebaseUser: bookingBloc.getFirebaseUser, orderRef: widget.order.orderRef)),
        );
        break;
      case PaymentType.card:
        onPayUsingCardOptionPressed();
        break;
      case PaymentType.gPay:
        onPayUsingGPayPressed();
        break;
    }
  }

  /*Padding buildPaymentTile(Payment paymentModel) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, left: 12.0, right: 12.0, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          int selected = paymentsList.indexOf(paymentModel, 0);
          print(selected);
          setState(() {
            paymentModel.isTap = !paymentModel.isTap;
            if (selected == 0) {
              paymentsList.elementAt(1).isTap = false;
              paymentsList.elementAt(2).isTap = false;
            } else if (selected == 1) {
              paymentsList.elementAt(0).isTap = false;
              paymentsList.elementAt(2).isTap = false;
            } else if (selected == 2) {
              paymentsList.elementAt(0).isTap = false;
              paymentsList.elementAt(1).isTap = false;
            }
          });
        },
        child: Container(
            height: 60.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(paymentModel.url),
                  Text(
                    paymentModel.name,
                    style: payStyle,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Opacity(
                        opacity: paymentModel.isTap == false ? 0.0 : 1.0,
                        child: Image.asset(
                          'assets/check@3x.png',
                          height: 24.0,
                          // width: 24.0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }*/

  static TextStyle appbarStyle = new TextStyle(
      fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle payStyle = new TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.43);

  static TextStyle buttonStyle = new TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.12);

  Widget getDifferentPaymentsOptionsColumn() {
    Payment pModel3 =
        new Payment('assets/payments/cash.png', "Pay With Cash", true);
    return Column(
      children: [
        //buildPaymentTile(pModel3),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),
            child: RadioListTile(
              value: PaymentType.cash,
              groupValue: paymentType,
              onChanged: (val) {
                setState(() {
                  paymentType = val;
                });
              },
              title: Text(
                "Pay via Cash",
                textAlign: TextAlign.center,
                style: payStyle,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),
            child: RadioListTile(
              value: PaymentType.card,
              groupValue: paymentType,
              onChanged: (val) {
                setState(() {
                  paymentType = val;
                });
              },
              title: Text(
                "Pay via Card",
                textAlign: TextAlign.center,
                style: payStyle,
              ),
            ),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),
            child: RadioListTile(
              value: PaymentType.gPay,
              groupValue: paymentType,
              onChanged: (val) {
                setState(() {
                  paymentType = val;
                });
              },
              title: Text(
                "Pay via Gpay",
                textAlign: TextAlign.center,
                style: payStyle,
              ),
            ),
          ),
        ),*/
      ],
    );
  }

  onPayUsingCardOptionPressed() async {
    double amount = widget.order.amountToPay * 100;
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: amount.round().toString(), currency: 'gbp');
    await dialog.hide();
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(
              milliseconds: response.success == true ? 1200 : 3000),
        ))
        .closed
        .then((_) async {
      if (response.success == true) {
        await bookingBloc.confirmPaymentWithCard();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OrderCreated(getFirebaseUser: bookingBloc.getFirebaseUser, orderRef: widget.order.orderRef)),
        );
      }
    });
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  onPayUsingGPayPressed() async {
    double amount = widget.order.amountToPay * 100;

    print("gpay");
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    var response = await StripeService.payUsingGooglePay(
        amount: amount.round().toString(), currency: 'INR');
    if (response.success == true) print("gpay " + response.success.toString());
    await dialog.hide();
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(
              milliseconds: response.success == true ? 1200 : 3000),
        ))
        .closed
        .then((_) async {
      if (response.success == true) {
        await bookingBloc.confirmPaymentWithGPay();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OrderCreated(getFirebaseUser: bookingBloc.getFirebaseUser)),
        );
      }
    });
  }
}

enum PaymentType { cash, card, gPay }
