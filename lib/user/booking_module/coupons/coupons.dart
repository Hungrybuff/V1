import 'package:flutter/material.dart';

class CouponsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
                Text(
                  'Apply Coupon',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
              child: RaisedButton(
            child: Text('APPLY COUPON'),
            onPressed: () {},
          )),
        ],
      ),
    );
  }
}
