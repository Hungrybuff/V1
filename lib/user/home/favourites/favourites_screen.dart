import 'package:flutter/material.dart';

class FavouritesList extends StatelessWidget {
  static String tag = 'fav-list';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(60.0),
            child: Text(
              'Your Favourite Food Stall',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ],
      ),
    );
  }
}
