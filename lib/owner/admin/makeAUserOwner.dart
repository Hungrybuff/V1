import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungrybuff/owner/admin/AdminBloc.dart';
import 'package:hungrybuff/owner/models/User.dart';

class MakeAUserOwner extends StatefulWidget {
  @override
  _MakeAUserOwnerState createState() => _MakeAUserOwnerState();
}

class _MakeAUserOwnerState extends State<MakeAUserOwner> {
  AdminBloc bloc = AdminBloc().getInstance();

  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.loadAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Make A User Owner"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.deepOrangeAccent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Enter email of user"),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.deepOrangeAccent,
                          ),
                          onPressed: () {
                            bloc.search(emailController.text);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: bloc.userStream,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (bloc.userEmail == null) {
                      return Text("Enter the email of the user to search");
                    }
                    if (snapshot.connectionState != ConnectionState.active &&
                        snapshot.connectionState != ConnectionState.done)
                      return Center(child: new CircularProgressIndicator());
                    if (snapshot.data == null) {
                      return Text(
                          "User with email doesn't exists. Please check email");
                    } else {
                      DocumentSnapshot documentSnapshot = snapshot.data;
                      User currentUser = new User.fromMap(snapshot.data.data);
                      return getUserTile(
                          currentUser, documentSnapshot.documentID);
                    }
                  }),
            ),
            /* child: FutureBuilder<DocumentSnapshot>(
              future: bloc.getUserData(),
              builder: (context, snapshot) {
                DocumentSnapshot documentSnapshot = snapshot.data;
                User currentUser = new User.fromMap(snapshot.data.data);
                if (snapshot.connectionState == ConnectionState.done)
                  return getUserTile(currentUser, documentSnapshot.documentID);
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return Center(
                    child: Container(
                  child:
                      Text("Enter the Email of the user do you want to search"),
                ));
              },
            ),*/
          ),
        )
      ],
    );
    return StreamBuilder<QuerySnapshot>(
        stream: bloc.usersListStream,
        builder: (context, snapshot) {
          QuerySnapshot usersSnapshot = snapshot.data;
          if (snapshot.connectionState != ConnectionState.active &&
              snapshot.connectionState != ConnectionState.done)
            return Center(child: new CircularProgressIndicator());
          return buildListViewOfUsers(usersSnapshot);
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
                  new Text(user.role == null ? "User" : user.role)
                ],
              ),
            ),
            new IconButton(
                icon: new Icon(Icons.verified_user),
                onPressed: () {
                  Map<String, String> map = new Map();
                  map["role"] = "owner";
                  Firestore.instance
                      .collection("users")
                      .document(documentID)
                      .updateData(map);
                })
          ],
        ),
      ),
    );
  }

  Widget buildListViewOfUsers(QuerySnapshot snapshot) {
    return new ListView.builder(
      itemBuilder: (context, index) {
        User currentUser = User.fromMap(snapshot.documents[index].data);
        return getPersonWidget(
            currentUser, snapshot, index, snapshot.documents.length);
      },
      itemCount: snapshot.documents.length,
    );
  }

  Widget getPersonWidget(
      User currentUser, QuerySnapshot snapshot, int index, int length) {
    return Column(
      children: <Widget>[
        getUserTile(currentUser, snapshot.documents[index].documentID),
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

  Widget getUserTile(User user, String userPath) {
    return ListTile(
      leading: buildLeading(user),
      title: buildTitle(user),
      subtitle: buildSubTitle(user),
      trailing: getRoleButton(user, userPath),
    );
  }

  Widget buildLeading(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.person,
          color: Colors.deepOrangeAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(getRole(user.role)),
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

/*  Widget buildTrailing(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        getRoleIcon(user),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(getText(user)),
        )
      ],
    );
  }*/

  /* Widget getRoleIcon(User user) {
    if (user.role == null || user.role == "user") {
      return Icon(Icons.add_circle_outline, color: Colors.green);
    } else if (user.role == "admin") {
      return Icon(
        Icons.verified_user,
        color: Colors.deepOrangeAccent,
      );
    } else {
      return Icon(
        Icons.cancel,
        color: Colors.redAccent,
      );
    }
  }

  String getText(User user) {
    if (user.role == null || user.role == "user") {
      return "Add";
    } else if (user.role == "admin") {
      return "Admin";
    } else {
      return "Remove";
    }
  }*/

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
        onPressed: () {
          showConfirmMessage(user.foodTruckId, userPath);
        },
      );
    }
  }

  void showConfirmMessage(String truckId, String userId) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        showFlutterToast("Removing Food truck");
        Navigator.pop(context);
        bloc.removeFoodTruck(truckId, userId);
        showFlutterToast("Successfully Removed Food truck");
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm?"),
      content: Text(
          "Do you want to remove this owner? Food Truck will be also deleted if you delete Owner."),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showFlutterToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }
}
