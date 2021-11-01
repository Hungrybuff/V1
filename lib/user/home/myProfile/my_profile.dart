import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/other/DummyScreen/newScreen.dart';
import 'package:hungrybuff/user/Authentication/bloc/AuthenticationBLOC.dart';
import 'package:hungrybuff/user/Authentication/ui/SplashScreen.dart';
import 'package:hungrybuff/user/Authentication/ui/change_password.dart';
import 'package:hungrybuff/user/Order_Tracking/BackendTest/BackendTestScreen.dart';
import 'package:hungrybuff/user/booking_module/cartScreen/cart_ui/cart_page_coupon_applied.dart';
import 'package:hungrybuff/user/home/aboutScreen/about_us.dart';
import 'package:hungrybuff/user/home/feedbackScreen/feedback_screen.dart';
import 'package:hungrybuff/user/home/support/UI/support_screen.dart';
import 'package:hungrybuff/user/home/terms_and_conditions/t_c_screen.dart';

class MyProfileScreen extends StatefulWidget {
  final FirebaseUser _firebaseUser;

  const MyProfileScreen(this._firebaseUser);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Profile was called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: ListView(children: <Widget>[
        /*  ListTile(
          title: InkWell(
              child: Text(
                'My Profile',
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileEdit()));
              }),
          leading: Icon(
            Icons.perm_identity,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileEdit()));
            },
          ),
        ),*/
        ListTile(
          title: Text('My Cart'),
          leading: Icon(
            Icons.card_giftcard,
            color: Colors.grey,
          ),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => FoodCartScreen())),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ),
        ListTile(
          title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedBackScreen()));
              },
              child: Text('Feedback')),
          leading: Icon(
            Icons.feedback,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedBackScreen()));
            },
          ),
        ),
        ListTile(
          title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
              child: Text('Change Password')),
          leading: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
        ),
        ListTile(
          title: Text('Rate Us'),
          leading: Icon(
            Icons.rate_review,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
              child: Text('About HungryBuff')),
          leading: Icon(
            Icons.add_box,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
            },
          ),
        ),
        ListTile(
          title: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndConditions()));
              },
              child: Text('Terms & Conditions')),
          leading: Icon(
            Icons.note_add,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditions()));
            },
          ),
        ),
        ListTile(
          title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SupportScreen()));
              },
              child: Text('Customer Support')),
          leading: Icon(
            Icons.supervisor_account,
            color: Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupportScreen()));
            },
          ),
        ),
        ListTile(
          title: InkWell(
              onTap: () {
                onTapSubmitted();
              },
              child: Text('Logout')),
          leading: Icon(
            Icons.do_not_disturb_alt,
            color: Colors.grey,
          ),
          trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                onTapSubmitted();
              }),
        ),
      ]),
    );
  }

  TextStyle logoutStyle = new TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(39, 39, 39, 1));

  TextStyle sureStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.08,
      color: Color.fromRGBO(39, 39, 39, 1));

  TextStyle noyesStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.12,
      color: Color.fromRGBO(255, 255, 255, 1));

  //temporary style
  TextStyle hungryStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(
        255,
        255,
        255,
        1,
      ),
      letterSpacing: 0.1);

  void onTapSubmitted() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 69.0,
                  ),
                  Text(
                    "Logout",
                    textAlign: TextAlign.left,
                    style: logoutStyle,
                  ),
                  Text(
                    "Are you sure you want to Logout?",
                    textAlign: TextAlign.left,
                    style: sureStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            print("No I am Staying");
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0)),
                          child: Text(
                            "NO",
                            style: noyesStyle,
                            textAlign: TextAlign.center,
                          ),
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 40,
                          child: RaisedButton(
                            onPressed: () {
                              AuthenticationBLOC authenticationBLOC =
                                  AuthenticationBLOC.getInstance();
                              authenticationBLOC.logOutUser(
                                  navigateToSplash: goToSplashScreen);
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Text(
                              "YES",
                              style: noyesStyle,
                              textAlign: TextAlign.center,
                            ),
                            color: Color.fromRGBO(245, 116, 14, 1),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void goToSplashScreen() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext c) => SplashScreen()));
  }

  void goToAPISAMPLESCREEN() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext c) => NewScreen()));
  }

  goToBackendTestScreen() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext c) => BackendTestScreen()));
  }
}
