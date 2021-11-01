import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:hungrybuff/owner/admin/AdminBloc.dart';
import 'package:hungrybuff/owner/admin/add_new_food_truck.dart';
import 'package:hungrybuff/owner/models/User.dart';

class OwnersListScreen extends StatefulWidget {
  @override
  _OwnersListScreenState createState() => _OwnersListScreenState();
}

class _OwnersListScreenState extends State<OwnersListScreen> {
  AdminBloc bloc = AdminBloc().getInstance();

  @override
  void initState() {
    super.initState();
    bloc.loadOwners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("List of owners"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: bloc.ownersStream,
        builder: (context, snapshot) {
          QuerySnapshot ownersSnapshot = snapshot.data;
          if (snapshot.connectionState != ConnectionState.active &&
              snapshot.connectionState != ConnectionState.done)
            return Center(child: new CircularProgressIndicator());
          return buildListViewOfOwners(ownersSnapshot);
          /*  new ListView.builder(
            itemBuilder: (context, index) {
              User currentUser =
                  User.fromMap(snapshot.data.documents[index].data);
              return getOwnerCard(
                  currentUser, snapshot.data.documents[index].documentID);
            },
            itemCount: snapshot.data.documents.length,
          );*/
        });
    /*return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("users")
            .where("role", isEqualTo: "owner")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.connectionState != ConnectionState.active)
            return new CircularProgressIndicator();
          return new ListView.builder(
            itemBuilder: (context, index) {
              User currentUser =
                  User.fromMap(snapshot.data.documents[index].data);
              return getOwnerCard(
                  currentUser, snapshot.data.documents[index].documentID);
            },
            itemCount: snapshot.data.documents.length,
          );
        });*/
  }

  Widget getOwnerCard(User user, String documentID) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 16.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(user.firstName + " " + user.lastName),
                  new Text(user.emailAddress),
                  new Text(user.phoneNumber),
                  new Text("Role = " + user.role),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: user.foodTruckId == null
                  ? Column(
                      children: <Widget>[
                        new IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () async {
                              gotoAddFoodTruckScreen(documentID);
                              /*FoodTruck foodTruck =
                                  DummyData().getADummyFoodTruck(documentID);
                              DocumentReference reference = await Firestore
                                  .instance
                                  .collection("trucks")
                                  .add(foodTruck.toJson());
                              user.foodTruckId = reference.documentID;
                              Firestore.instance
                                  .collection("users")
                                  .document(documentID)
                                  .updateData(user.toMap());*/
                            }),
                        new Text("No food truck, click here to add one"),
                      ],
                    )
                  : new Text("Food truck ID = " + user.foodTruckId),
            )
          ],
        ),
      ),
    );
  }

  void gotoAddFoodTruckScreen(String documentID) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (c) => AddNewFoodTruck(documentID)));
  }

  Widget buildListViewOfOwners(QuerySnapshot snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) {
        User currentUser = User.fromMap(snapshot.documents[index].data);
        return getCard(currentUser, snapshot, index, snapshot.documents.length);
        /* getPersonWidget(
                currentUser, snapshot, index, snapshot.documents.length);*/
      },
      itemCount: snapshot.documents.length,
    );
  }

  Widget getPersonWidget(
      User currentUser, QuerySnapshot snapshot, int index, int length) {
    return Column(
      children: <Widget>[
        getOwnerTile(currentUser, snapshot.documents[index].documentID),
        index == (length - 1)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  thickness: 2,
                ),
              )
      ],
    );
  }

  Widget getOwnerTile(User user, String userPath) {
    return ListTile(
      leading: buildLeading(user),
      title: buildTitle(user),
      subtitle: buildSubTitle(user),
      trailing: buildTrailing(user),
    );
  }

  Widget buildLeading(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.person,
          color: Colors.deepOrangeAccent,
          size: 40,
        ),
      ],
    );
  }

  Widget buildTitle(User user) {
    return Text(user.firstName + " " + user.lastName);
  }

  Widget buildSubTitle(User user) {
    return Text(user.emailAddress);
  }

  String getRole(String role) {
    if (role == null || role == "user")
      return " User";
    else if (role == "admin")
      return "Admin";
    else
      return "Owner";
  }

  Widget getRoleButton(User user, String userPath) {
    if (user.role == null || user.role == "user") {
      return IconButton(
        icon: Icon(
          Icons.add_circle_outline,
          color: Colors.green,
        ),
        onPressed: () {
          bloc.makeUserAsOwner(user, userPath);
        },
      );
    } else if (user.role == "admin") {
      return IconButton(
        icon: Icon(
          Icons.verified_user,
          color: Colors.deepOrangeAccent,
        ),
        onPressed: null,
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.cancel,
          color: Colors.redAccent,
        ),
        onPressed: () {},
      );
    }
  }

  Widget buildTrailing(User user) {
    if (user.foodTruckId == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add_circle,
              color: Colors.green,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Add Truck",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.local_shipping,
            color: Colors.deepOrangeAccent,
            size: 30,
          ),
        ],
      );
      /*return Column(
        children: <Widget>[
          user.foodTruckId == null
              ? Icon(
                  Icons.add_circle,
                  color: Colors.green,
                )
              : Text(
                  user.foodTruckId,
                )
        ],
      );*/
    }
  }

  Widget getCard(User user, QuerySnapshot snapshot, int index, int length) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          user.firstName + " " + user.lastName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          user.emailAddress,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Truck Id:" +
                              (user.foodTruckId == null
                                  ? "No food Truck.Add a truck"
                                  : user.foodTruckId),
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    user.foodTruckId == null
                        ? IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            onPressed: () {
                              gotoAddFoodTruckScreen(
                                  snapshot.documents[index].documentID);
                            },
                          )
                        : Icon(
                            Icons.local_shipping,
                            color: Colors.deepOrangeAccent,
                            size: 30,
                          ),
                  ],
                ),
              )
            ],
          ),
          index == (length - 1)
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Divider(
                    thickness: 2,
                  ),
                )
        ],
      ),
    );
  }
}
