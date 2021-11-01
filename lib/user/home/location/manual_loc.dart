import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/widgets.dart';

class ManualLocation extends StatefulWidget {
  @override
  _ManualLocationState createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  UtilWidgets uWid = new UtilWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              _searchBar(),
              _usingGPS(),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: _chooseLocation(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 10.0),
                          child: InkWell(
                            onTap: () {
                              /*                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentOptions()));
                            },*/
                            },
                            focusColor: Colors.purple,
                            child: Text(
                              list[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.7,
                          // color: Colors.black,
                        )
                      ]);
                }),
          )
        ],
      ),
    ));
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(243, 243, 243, 1)),
        height: 44.0,
        // width: 319.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 245.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your Location',
                  ),
                ),
              ),
            ),
            // Text('Search Bar'),
            Container(
              child: IconButton(
                color: Colors.grey,
                icon: Icon(Icons.search),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SearchResults()));
                  return _showDialog();
                },
              ),
            ),
            // Text('Icon Button'),
          ],
        ),
      ),
    );
  }

  Widget _usingGPS() {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        height: 44.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: Icon(
                Icons.gps_fixed,
                color: Colors.orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9.0, top: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Use Current Location',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromRGBO(237, 74, 21, 1)),
                    ),
                  ),
                  Text(
                    'Using GPS',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromRGBO(159, 169, 159, 1)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: new Container(
              height: 400,
              width: 350,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 130,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage(
                        'assets/location/sd.png',
                        //    fit: BoxFit.cover
                      )),
                    ),
                    child: Image.asset(
                      'assets/location/loc.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      'Enable your Location',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      'Please allow to use your location to show nearby restaurant on the map.',
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(159, 159, 159, 1)),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.deepOrange,
                      onPressed: () {},
                      child: Text(
                        'Enable Location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _chooseLocation() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 20,
            child: Text(
              'Choose your Location',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]);
  }

  List<String> list = [
    "Marthalli",
    "BTM Layout",
    "HSR Layout",
    "Banshankari",
    "Basavannagudi",
    "Domlur",
    "Jayanagar",
    "Koramangala",
    "RajajiNagar",
    "Sadhashivnagar",
    "Nagarbhavi",
    "Mekhri Circle",
    "Gunatha Vihar",
    "Punjagutta",
    "Secunderabad",
    "Moula Ali",
    "Madhapur",
    "Paradise",
    "Parade Ground",
    "Durgam Cheruvu",
    "Hitech City",
    "Gachibowli",
    "Manikonda",
    "Jubilee Hills",
    "Banjara Hills"
  ];

  List<String> getList() {
    list.add("Alkapur");
    return list;
  }
}

class LocModel {
  String name;

  LocModel(this.name);

  @override
  String toString() {
    return 'LocModel{name : $name}';
  }
}

class LocationsSource {
  List<LocModel> list = new List();

  LocModel model = new LocModel("Marthalli");
  LocModel model1 = new LocModel("Bayappanahalli");
  LocModel mode2 = new LocModel("BTM Layout");
  LocModel mode3 = new LocModel("HSR Layout");
  LocModel mode4 = new LocModel("Jayanagar Extension");
  LocModel mode5 = new LocModel("Ganga Nagar");
  LocModel mode6 = new LocModel("Mekhri Circle");

  List<LocModel> getList() {
    list.clear();
    list.add(model);
    list.add(model1);
    list.add(mode2);
    list.add(mode3);
    list.add(mode4);
    list.add(mode5);
    list.add(mode6);

    return list;
  }
}
