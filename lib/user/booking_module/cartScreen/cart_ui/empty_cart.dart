import 'package:flutter/material.dart';
import 'package:hungrybuff/user/home/home/home_screen.dart';

class EmptyCart extends StatefulWidget {
  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    print("empty Card Called");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/cart/blank_food.png',
              height: 150.0,
            ),
            Text(
              'No Food in Your Cart',
              style: noStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: RaisedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen())),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(24.0)),
                child: Text(
                  "Hungry! Make Some Order",
                  style: hungryStyle,
                  textAlign: TextAlign.center,
                ),
                color: Color.fromRGBO(245, 116, 14, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextStyle titleStyle = new TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(39, 39, 39, 1),
  );

  final TextStyle noStyle = new TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(
      58,
      58,
      58,
      1,
    ),
  );

  final TextStyle hungryStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(
        255,
        255,
        255,
        1,
      ),
      letterSpacing: 0.1);
}
