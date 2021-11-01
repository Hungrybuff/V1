import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/event_model.dart';
import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/other/utils/styles.dart';
import 'package:hungrybuff/user/home/home/home_bloc/home_bloc.dart';
import 'package:hungrybuff/user/home/productdetails/productsui/food_truck_screen.dart';
import 'package:hungrybuff/user/home/searchScreen/search_trucks.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  HomeBloc _homeBloc = HomeBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return buildForeground();
  }

  Widget buildForeground() {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset('assets/home/bg@3x.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  welcomeMessage(),
                  _searchBar(),
                  _nearByText(),
                  bodyNearTrucks(),
                ],
              ),
            ),
          ],
        ),
        _famousFoodText(),
        //bodyNearTrucks(),
//        _upcomingEvents(),
//        getHomeEvents(),
      ],
    );
  }

  Widget _nearByText() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Near by Food Trucks',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: Colors.white,
            iconSize: 20.0,
            onPressed: () {
              print('Near by Button is tapped');
            },
          ),
        ]);
  }

  Widget _famousFoodText() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Famous Food Trucks',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: Colors.black,
              iconSize: 20.0,
              onPressed: () {
                print('Famous Foods Button is tapped');
              },
            ),
          ]),
    );
  }

  Widget _upcomingEvents() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Upcoming & Running Events',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: Colors.black,
              iconSize: 20.0,
              onPressed: () {
                print('Upcoming events Button is tapped');
              },
            ),
          ]),
    );
  }

  Widget welcomeMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<String>(
                    future: _homeBloc.getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return new CircularProgressIndicator();
                      return Text(
                        "Welcome " + snapshot.data,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'MontSerrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Showing results within 1 mile',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Card(
              child: new IconButton(
                  color: Colors.orange,
                  icon: new Icon(Icons.sort),
                  onPressed: () {}),
            ),
          ]),
    );
  }

  Widget getTrucks(FoodTruck truckModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodTruckDetailsScreen(truckModel)));
                    },
                    child: backgroundImage(truckModel)),
                Visibility(
                  visible: truckModel.preBooking,
                  child: Positioned(
                      bottom: 10.0,
                      right: 20.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.green,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                            child: Text(
                              "Pre - Booking",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ))),
                ),
              ],
            ),
            Text(
              truckModel.foodTruckName,
              style: UtilStyles.boldBlack,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.location_on),
                Text(truckModel.location)
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 10.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                            child: Text(
                              truckModel.rating.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    )),
                Text(truckModel.fromTime.toString()),
                Text(
                  truckModel.isOpen ? "Open" : "Closed",
                  style: TextStyle(color: Colors.redAccent, fontSize: 15.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getFTrucks(FoodTruck fTruckModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodTruckDetailsScreen(fTruckModel)));
                    },
                    child: backgroundImageFT(fTruckModel)),
                Visibility(
                  visible: fTruckModel.preBooking,
                  child: Positioned(
                      bottom: 10.0,
                      right: 20.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.green,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                            child: Text(
                              "Pre - Booking",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ))),
                ),
              ],
            ),
            Text(
              fTruckModel.foodTruckName,
              style: UtilStyles.boldBlack,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.location_on),
                Text(fTruckModel.location)
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 10.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                            child: Text(
                              fTruckModel.rating.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    )),
                Text(fTruckModel.fromTime.toString()),
                Text(
                  fTruckModel.isOpen ? "Open" : "Closed",
                  style: TextStyle(color: Colors.redAccent, fontSize: 15.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

//  Widget getEvents(ExploreEvents eventsModel) {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: IntrinsicWidth(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Stack(
//              children: <Widget>[
//                GestureDetector(
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => FoodTruckScreen()));
//                    },
//                    child: backgroundImageEvents(eventsModel)),
//              ],
//            ),
//            Text(
//              eventsModel.name,
//              style: UtilStyles.boldBlack,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Icon(Icons.location_on),
//                Text(eventsModel.location)
//              ],
//            ),
//            Container(
//                child: Padding(
//              padding: const EdgeInsets.only(
//                left: 4.0,
//                top: 2.0,
//              ),
//              child: Row(
//                children: <Widget>[
//                  Icon(
//                    Icons.calendar_today,
//                    size: 15.0,
//                    color: Colors.black,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(
//                        top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
//                    child: Text(
//                      eventsModel.timings.toString(),
//                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
//                    ),
//                  )
//                ],
//              ),
//            )),
//          ],
//        ),
//      ),
//    );
//  }

  Widget backgroundImage(FoodTruck truckModel) {
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              truckModel.images,
              width: 200.0,
              height: 150.0,
              fit: BoxFit.fill,
            )));
  }

//  Widget backgroundImageN(NearTrucks truckModel) {
//    return Container(
//        child: ClipRRect(
//            borderRadius: BorderRadius.circular(15.0),
//            child: Image.network(
//              truckModel.image,
//              width: 200.0,
//              height: 150.0,
//              fit: BoxFit.fill,
//            )));
//  }

  Widget backgroundImageFT(FoodTruck fTruckModel) {
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              fTruckModel.images,
              width: 200.0,
              height: 150.0,
              fit: BoxFit.fill,
            )));
  }

  Widget backgroundImageEvents(Event eventsModel) {
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              eventsModel.image,
              width: 260.0,
              height: 150.0,
              fit: BoxFit.cover,
            )));
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          showSearch(context: context, delegate: SearchResults());
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search Dishes, Food Trucks',
                ),
                Icon(Icons.search),
                // Text('Icon Button'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardTruck() {
    return SizedBox(
      height: 100.0,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/home/shop1@3x.png'),
            ],
          )
        ],
      ),
    );
  }

  Widget getNearTrucks(FoodTruck model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodTruckDetailsScreen(model)));
                    },
                    child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              model.images.replaceAll("\"", ""),
                              width: 200.0,
                              height: 150.0,
                              fit: BoxFit.fill,
                            )))),
                Positioned(
                  bottom: 10.0,
                  right: 20.0,
                  child: Visibility(
                    visible: model.preBooking,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                          child: Text(
                            'Pre-Booking',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Text(
              model.foodTruckName,
              style: UtilStyles.boldBlack,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.location_on),
                Text(model.location == null ? 'No Location' : model.location)
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 10.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                            child: Text(
                              model.rating.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    )),
                Text('${model.fromTime} - ${model.toTime}'),
                Text(
                  model.isOpen ? 'OPEN' : '',
                  style: TextStyle(color: Colors.green, fontSize: 15.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyNearTrucks() {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('trucks')
            .where("isOpen", isEqualTo: true)
            .orderBy("fromTime")
            .snapshots(),
        builder: (context, snapshot) {
          print('near trucjks');
          print(snapshot.connectionState.toString());
          if (snapshot.connectionState != ConnectionState.active &&
              snapshot.connectionState != ConnectionState.done)
            return Center(child: CircularProgressIndicator());
          print('Trucks Length ${snapshot.data.documents.length}');
          if (snapshot.data.documents.length == 0)
            return Center(child: Text('No Trucks'));
          else
            return Container(
              height: 265.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  FoodTruck foodTruck =
                      FoodTruck.fromJson(snapshot.data.documents[index].data);
                  foodTruck.foodTruckId =
                      snapshot.data.documents[index].documentID;
                  return getNearTrucks(foodTruck);
                },
              ),
            );
        });
  }
}
