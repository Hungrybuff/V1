import 'package:flutter/material.dart';

class OrderAccepted extends StatefulWidget {
  @override
  _OrderAcceptedState createState() => _OrderAcceptedState();
}

class _OrderAcceptedState extends State<OrderAccepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/order_fail/bg_order@3x.png',
                      ),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo/logo_order@3x.png',
                      height: 68.9,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Image.asset(
                        'assets/order_fail/confirm_tick_orderpng',
                        height: 207.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 90.0, right: 90.0),
                      child: Container(
                        height: 37,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: Ink(
                          child: Text(
                            "Awesome",
                            textAlign: TextAlign.center,
                            style: failStyle,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Congratulations.",
                          style: terribleStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Your order is accepted!",
                          style: terribleStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Have patience you can collect your",
                        style: payWasStyle,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "order in 20 mins",
                          style: payWasStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      print("Order Again");
                    },
                    color: Color.fromRGBO(245, 116, 14, 1),
                    child: Text(
                      "More Hungry, Let's do again",
                      style: tryStyle,
                      textAlign: TextAlign.center,
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextStyle failStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      color: Color.fromRGBO(241, 95, 17, 1));

  TextStyle terribleStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      color: Color.fromRGBO(255, 255, 255, 1));

  TextStyle payWasStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      color: Colors.black);

  TextStyle tryStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.2,
      color: Colors.white);
}
