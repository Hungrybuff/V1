import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/colors.dart';

import 'manual_loc.dart';

class EnableLocation extends StatefulWidget {
  static String tag = 'enable-location';

  @override
  _EnableLocationState createState() => _EnableLocationState();
}

class _EnableLocationState extends State<EnableLocation> {
  UtilColors ucol = new UtilColors();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _locImage(),
            Padding(padding: const EdgeInsets.only(top: 50.0), child: _hiNice),
            _textColumn,
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: _gradientButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: _selectManually(),
            ),
          ],
        ),
      ),
    );
  }

  get _textColumn {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text('Choose your location to start finding', style: style2),
      ),
      Text(
        'restaurants around you',
        style: style2,
      ),
    ]);
  }

  get _hiNice {
    return Text('Hi nice to meet You', style: style1);
  }

  Widget _locImage() {
    return Container(
      height: 210.0,
      width: 231.4,
      child: Image.asset(
        'assets/location/location@3x.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _selectManually() {
    return Container(
      //   padding: EdgeInsets.only(top: 50.0),
      child: InkWell(
        child: Text(
          'Select it manually',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => ManualLocation()));
        },
      ),
    );
  }

  Widget _gradientButton() {
    return Container(
      height: 54.4,
      width: 314.9,
      child: RaisedButton(
        onPressed: () {
          print('It Worked');
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ucol.gradient1, ucol.gradient2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Image.asset('assets/location/icon current.png'),
                ),
                Container(
                  //  padding: EdgeInsets.only(left: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Use Current Location",
                    style: style3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  final style1 = new TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final style3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final style2 =
      TextStyle(fontSize: 16.0, color: Color.fromRGBO(159, 159, 159, 1));
}
