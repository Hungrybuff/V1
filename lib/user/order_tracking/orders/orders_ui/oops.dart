import 'package:flutter/material.dart';

class WrongOrder extends StatefulWidget {
  @override
  _WrongOrderState createState() => _WrongOrderState();
}

class _WrongOrderState extends State<WrongOrder> {
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
                        'assets/order_fail/bg_failed@3x.png',
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
                        'assets/order_fail/failed_tick_order@3x.png',
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
                            "Failed",
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
                          "Oops! Something went",
                          style: terribleStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "terribly wrong here",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your payment wasn't",
                        style: payWasStyle,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "completed.",
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
                      print("Tried Again");
                    },
                    color: Color.fromRGBO(235, 29, 28, 1),
                    child: Text(
                      "Please try again",
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
      color: Color.fromRGBO(231, 23, 23, 1));

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
