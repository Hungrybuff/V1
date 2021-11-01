import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/other/utils/styles.dart';

class UtilWidgets {
  Widget roundedButtonText(
      BuildContext context,
      double height,
      double width,
      double borderRad,
      Widget route,
      Color boxColor,
      String buttonText,
      TextStyle buttonStyle,
      [double x,
      double y]) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRad),
        color: boxColor,
      ),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => route));
          },
          child: Text(buttonText, style: buttonStyle)),
      alignment: Alignment(x, y),
    );
  }

  Widget roundedButtonTextWithNavigator(
      BuildContext context,
      double height,
      double width,
      double borderRad,
      Function route,
      Color boxColor,
      String buttonText,
      TextStyle buttonStyle,
      [double x,
      double y]) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRad),
        color: boxColor,
      ),
      child: InkWell(
          onTap: () => route, child: Text(buttonText, style: buttonStyle)),
      alignment: Alignment(x, y),
    );
  }

//  Widget bottomBar(BuildContext context) {
//    bool fav = false;
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      mainAxisSize: MainAxisSize.max,
//      children: <Widget>[
//        IconButton(
//          icon: Icon(Icons.explore),
//          onPressed: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => HomeScreen()));
//          },
//          color: Colors.grey,
//          highlightColor: Colors.orange,
//        ),
//        IconButton(
//          icon: Icon(Icons.event),
//          onPressed: () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => EventDetailsScreen()));
//          },
//          color: Colors.grey,
//          highlightColor: Colors.orange,
//        ),
//        IconButton(
//          icon: Icon(Icons.save),
//          onPressed: () {
//            fav == true
//                ? print('Fav contains list')
//                : Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => FavouritesBlank()));
//          },
//          color: Colors.grey,
//          highlightColor: Colors.orange,
//        ),
//        IconButton(
//          icon: Icon(Icons.shopping_cart),
//          onPressed: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => WrongOrder()));
//          },
//          color: Colors.grey,
//          highlightColor: Colors.orange,
//        ),
//        IconButton(
//          icon: Icon(Icons.account_box),
//          onPressed: () {
//            print('profile clicked');
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => MyProfileScreen()));
//          },
//          color: Colors.grey,
//          highlightColor: Colors.orange,
//        ),
//      ],
//    );
//  }

  Widget OtpField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 56.2,
          width: 56.2,
          child: TextField(
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          height: 56.2,
          width: 56.2,
          child: TextField(
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          height: 56.2,
          width: 56.2,
          child: TextField(
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          height: 56.2,
          width: 56.2,
          child: TextField(
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget gradientButton(double height, double width, BuildContext context,
      Widget route, String text) {
    UtilColors ucol = new UtilColors();
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => route));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ucol.gradient2, ucol.gradient1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            //  padding: EdgeInsets.only(left: 20.0),
            alignment: Alignment.center,
            child: Text(
              text,
              style: UtilStyles.style3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
