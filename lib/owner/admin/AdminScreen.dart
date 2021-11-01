import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/Authentication/UI/auth_screen.dart';
import 'package:hungrybuff/owner/admin/AdminBloc.dart';
import 'package:hungrybuff/owner/admin/makeAUserOwner.dart';
import 'package:hungrybuff/owner/admin/owners_list_screen.dart';
import 'package:hungrybuff/owner/models/User.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminBloc bloc = AdminBloc().getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return new FutureBuilder<User>(
      future: bloc.loadAdminProfile(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(
                child: new Text(
                    "Error loading Admin Profile" + snapshot.error.toString()),
              );
            User user = snapshot.data;
            return buildUserInfo(user);
        }
        return null; // unreachable
      },
    );

    /* return Column(
      children: <Widget>[
        */ /* RaisedButton(
          child: new Text("Add new Food truck"),
          onPressed: addNewFoodTruck,
        ),*/ /*
        RaisedButton(
          child: new Text("Edit Food truck"),
          onPressed: editFoodTruck,
        ),
        RaisedButton(
          child: new Text("List of owners"),
          onPressed: listOfOwnersScreen,
        ),
        RaisedButton(
          child: new Text("make a user owner"),
          onPressed: makeAUserOwner,
        ),
        RaisedButton(
          child: new Text("Logout"),
          onPressed: logout,
        ),
      ],
    );*/
  }

  void editFoodTruck() {}

  void addNewFoodTruck() {
    /* Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (c) => */ /*AddNewFoodTruck()*/ /* AddNewFoodTruckScreen()));*/
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
        context, new MaterialPageRoute(builder: (c) => AuthScreen())));
  }

  void listOfOwnersScreen() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (c) => OwnersListScreen()));
  }

  void makeAUserOwner() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (c) => MakeAUserOwner()));
  }

  Widget buildUserInfo(User user) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[buildProfile(user), buildAdminFeatures()],
        ),
      ),
    );
  }

  Container buildProfile(User user) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: CurvePainter(),
        child: Column(
          children: <Widget>[
            buildIcon(),
            buildAdminText(),
            buildAdminName(user)
          ],
        ),
      ),
    );
  }

  Padding buildAdminName(User user) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        user.firstName + " " + user.lastName,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Text buildAdminText() {
    return Text("Admin",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ));
  }

  Icon buildIcon() {
    return Icon(
      Icons.person,
      size: 150,
      color: Colors.white,
    );
  }

  Widget buildAdminFeatures() {
    return Column(
      children: <Widget>[
        //editFoodTruckTile(),
        makeUserAOwnerTile(),
        listOfOwnersTile(),
        logOutTile(),
      ],
    );
  }

  Card editFoodTruckTile() {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {},
        leading: Icon(
          Icons.edit,
          color: Colors.deepOrangeAccent,
        ),
        title: Text("Edit Food Truck"),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget makeUserAOwnerTile() {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          makeAUserOwner();
        },
        leading: Icon(
          Icons.person_add,
          color: Colors.deepOrangeAccent,
        ),
        title: Text("Make User as Owner"),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget listOfOwnersTile() {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          listOfOwnersScreen();
        },
        leading: Icon(
          Icons.list,
          color: Colors.deepOrangeAccent,
        ),
        title: Text("List Of Owners"),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget logOutTile() {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          logout();
        },
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.deepOrangeAccent,
        ),
        title: Text("Log Out"),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.deepOrangeAccent;
    paint.style = PaintingStyle.fill; // Change this to fill
    var path = Path();
    path.moveTo(0, size.height * 0.85); //left bottom
    path.quadraticBezierTo(size.width / 2, size.height * 1.0, size.width,
        size.height * 0.85); //right bottom
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
