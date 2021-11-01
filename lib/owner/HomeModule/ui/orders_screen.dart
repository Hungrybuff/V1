import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/HomeModule/ui/accepted_orders_tab.dart';
import 'package:hungrybuff/owner/HomeModule/ui/completed_orders_tab.dart';
import 'package:hungrybuff/owner/HomeModule/ui/new_orders_tab.dart';
import 'package:hungrybuff/owner/HomeModule/ui/delivered_orders_tab.dart';
import 'package:hungrybuff/owner/HomeModule/ui/rejected_order_tab.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:rxdart/rxdart.dart';

class OrdersScreen extends StatefulWidget {

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  OwnerHomeBloc homeBloc = OwnerHomeBloc.getInstance();

  TextEditingController searchController = new TextEditingController();
  TabController tabController;

  BehaviorSubject<int> indexStreamController =
      new BehaviorSubject<int>.seeded(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Stream<int> get indexStream => indexStreamController.stream;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 5);
    indexStreamController.add(0);
    tabController.addListener(() {
      indexStreamController.add(tabController.index);
    });
  }

  @override
  void dispose() {
    indexStreamController.close();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 200,
                title: buildTitle(),
                flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.all(0.0),
                    title: buildAppBar(),
                    background: buildSliverBackGround()),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicator: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    isScrollable: true,
                    controller: tabController,
                    tabs: getTabs(),
                  ),
                ),
              ),
            ];
          },
          body: buildContent(),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      child: TabBarView(
        controller: tabController,
        children: getTabContents(),
      ),
    );
  }

  List<Widget> getTabs() {
    return [
      Tab(
        child: StreamBuilder<int>(
            stream: indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                "New",
                style: new TextStyle(
                    color: snapshot.data == 0
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    backgroundColor: Colors.transparent),
              );
            }),
      ),
      Tab(
        child: StreamBuilder<int>(
            stream: indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                "Accepted",
                style: new TextStyle(
                    color: snapshot.data == 1
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    backgroundColor: Colors.transparent),
              );
            }),
      ),
      Tab(
        child: StreamBuilder<int>(
            stream: indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                "Completed",
                style: new TextStyle(
                    color: snapshot.data == 2
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    backgroundColor: Colors.transparent),
              );
            }),
      ),
      Tab(
        child: StreamBuilder<int>(
            stream: indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                "Delivered",
                style: new TextStyle(
                    color: snapshot.data == 3
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    backgroundColor: Colors.transparent),
              );
            }),
      ),
      Tab(
        child: StreamBuilder<int>(
            stream: indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                "Rejected",
                style: new TextStyle(
                    color: snapshot.data == 4
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    backgroundColor: Colors.transparent),
              );
            }),
      ),
    ];
  }

  Container buildSliverBackGround() {
    return Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(240, 93, 33, 1),
              Color.fromRGBO(247, 114, 45, 1),
              Color.fromRGBO(246, 96, 32, 1),
              Color.fromRGBO(237, 77, 25, 1)
            ],
          ),
        ));
  }

  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder<FoodTruck>(
                stream: homeBloc.truckStream,
                initialData: homeBloc.foodTruckStreamController.value,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState != ConnectionState.active &&
                      snapshot.connectionState != ConnectionState.done)
                    return new CircularProgressIndicator();
                  else {
                    FoodTruck foodTruck = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          foodTruck.foodTruckName,
                          style: titleStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                                Text(
                                  foodTruck.location == null
                                      ? "Edit Location"
                                      : foodTruck.location,
                                  style: locStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onTap: () {
                                showBottomSheet(foodTruck.location);
                                //_modalBottomSheet();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              Container(
                height: 32,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: 'Search Order ID',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              print('Search Initiated');
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.blueGrey,
                              size: 18.0,
                            ),
                          ),
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(String location) {
    TextEditingController locationController =
        new TextEditingController(text: location);
    _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: new Container(
          child: Card(
            borderOnForeground: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 10.0,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          "Enter location",
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.deepOrange)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: locationController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter location';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    homeBloc.updateLocationByOwner(
                                        locationController.text);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.black,
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildToggle(),
          ],
        ),
      ],
    );
  }

  Widget buildToggle() {
    return FutureBuilder<Stream<QuerySnapshot>>(
        initialData: null,
        future: homeBloc.getTrucksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return new Text("");
          return StreamBuilder<QuerySnapshot>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done &&
                    snapshot.connectionState != ConnectionState.active)
                  return new CircularProgressIndicator();
                if (snapshot.data.documents.length < 1)
                  return new Text("Error");
                FoodTruck foodTruck =
                    FoodTruck.fromJson(snapshot.data.documents[0].data);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Switch(
                      value: foodTruck.isOpen,
                      onChanged: (bool val) async {
                        foodTruck.isOpen = val;
                        if (val) {
                          await homeBloc.getLocation();
                        }
                        Firestore.instance
                            .collection("trucks")
                            .document(snapshot.data.documents[0].documentID)
                            .updateData({"isOpen": val});
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Color.fromRGBO(76, 217, 100, 1),
                    ),
                    Visibility(
                      visible: foodTruck.isOpen,
                      child: Text(
                        'Online',
                        style: onStyle,
                      ),
                    ),
                  ],
                );
              });
        });
  }

  Stream<QuerySnapshot> getStream() {
    return Firestore.instance
        .collection("trucks")
        .where("ownerId", isEqualTo: homeBloc.currentUser.uid)
        .snapshots();
  }

  List<Widget> getTabContents() {
    return <Widget>[
      NewOrdersTab(),
      AcceptedOrdersTab(),
      CompletedOrdersTab(),
      DeliveredOrdersTab(),
      RejectedOrdersTab(),
    ];
  }

  TextStyle tabStyle = new TextStyle(
      color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold);

  TextStyle titleStyle = new TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle onStyle = new TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle locStyle = new TextStyle(
      fontSize: 10, fontWeight: FontWeight.normal, color: Colors.white);
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset.toString());
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(shrinkOffset == 0
              ? 48
              : shrinkOffset < 48 ? 0 : shrinkOffset - 48)),
      child: new Container(
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(240, 93, 33, 1),
              Color.fromRGBO(247, 114, 45, 1),
              Color.fromRGBO(246, 96, 32, 1),
              Color.fromRGBO(237, 77, 25, 1)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: _tabBar,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
