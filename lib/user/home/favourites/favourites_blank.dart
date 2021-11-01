import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/widgets.dart';

class FavouritesBlank extends StatefulWidget {
  @override
  _FavouritesBlankState createState() => _FavouritesBlankState();
}

class _FavouritesBlankState extends State<FavouritesBlank> {
  @override
  Widget build(BuildContext context) {
    UtilWidgets uWid = new UtilWidgets();

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Your Favourite Food Stall',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Image.asset(
                  'assets/favblank/pasta@3x.png',
                  height: 150,
                  fit: BoxFit.fill,
                ),
                Text('Nothing found in your favourite list',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: RaisedButton(
                    onPressed: () {
                      /*  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));*/
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0)),
                    child: Text(
                      "Add some Food",
                      style: hungryStyle,
                      textAlign: TextAlign.center,
                    ),
                    color: Color.fromRGBO(245, 116, 14, 1),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

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
