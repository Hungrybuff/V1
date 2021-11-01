import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/colors.dart';

class EventsMap extends StatefulWidget {
  @override
  _EventsMapState createState() => _EventsMapState();
}

class _EventsMapState extends State<EventsMap> {
  TextStyle titleStyle = new TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      letterSpacing: 0.1);

  TextStyle locStyle = new TextStyle(
      fontSize: 14.0,
      color: Color.fromRGBO(159, 159, 159, 1),
      letterSpacing: -0.09);

  TextStyle descStyle = new TextStyle(
      fontSize: 14.0,
      color: Color.fromRGBO(58, 58, 58, 1),
      letterSpacing: -0.09);

  TextStyle mapStyle = new TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.12);

  UtilColors uCol = new UtilColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            height: 300,
            alignment: Alignment.topCenter,
            width: double.infinity,
            decoration: new BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/event_map/event_map.png',
                  ),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: () {
                      print("Shared");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Truffle Making- Om Sweets & Snacks',
                  maxLines: 2,
                  style: titleStyle,
                  overflow: TextOverflow.clip,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Young Women Christian Association",
                        style: locStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                      size: 18.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Mon, 20 Jan 10:30AM - 1:30PM",
                        style: locStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "oadfanfpak ohsaoifhoafpopo pip asfpnf pnapfn pansfp npnapodjgponpn panf ",
                  maxLines: 10,
                  overflow: TextOverflow.clip,
                  style: descStyle,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          )),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 56.4,
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [uCol.gradient2, uCol.gradient1]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: Text(
                    "CHECK ON MAP",
                    style: mapStyle,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24.0,
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
