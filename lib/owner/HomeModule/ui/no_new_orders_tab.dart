import 'package:flutter/material.dart';

class NoNewOrdersTab extends StatefulWidget {
  @override
  _NoNewOrdersTabState createState() => _NoNewOrdersTabState();
}

class _NoNewOrdersTabState extends State<NoNewOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 120.0,
              child: Image.asset('assets/orders/blank_food.png')),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'No Order Yet!',
              style: noStyle,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ));
  }

  TextStyle noStyle = new TextStyle(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
}
