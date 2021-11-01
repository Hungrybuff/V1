import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungrybuff/owner/Authentication/UI/LoginScreen.dart';
import 'package:hungrybuff/owner/Authentication/UI/change_password.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/HomeModule/ui/myOrders.dart';
import 'package:hungrybuff/owner/HomeModule/ui/stall_update.dart';
import 'package:hungrybuff/owner/Packages/support_screen.dart';
import 'package:hungrybuff/owner/models/User.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  OwnerHomeBloc bloc = OwnerHomeBloc.getInstance();

  @override
  void initState() {
    super.initState();
    bloc.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User>(
          stream: bloc.myProfileStream,
          initialData: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active &&
                snapshot.connectionState != ConnectionState.done)
              return Center(child: new CircularProgressIndicator());
            else {
              User user = snapshot.data;
              print("user data" + user.toString());
              return getBody(user);
            }
          }),
    );
  }

  ImageProvider getProfileImage(String profilePicUrl) {
    if (profilePicUrl == null) {
      return AssetImage('assets/defaultProfile.png');
    } else {
      return NetworkImage(profilePicUrl);
    }
  }

  Widget divider() {
    return Divider(
      color: Colors.grey,
      thickness: 0.3,
    );
  }

  Widget listTile(
      {IconData icon,
      String option,
      bool isEarning,
      String price,
      IconData trailingIcon,
      void yourFunction()}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: InkWell(
        onTap: () {
          yourFunction();
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                Icon(
                  icon,
                  color: Colors.grey,
                  size: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    option,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Visibility(
                        visible: isEarning,
                        child: Text(
                          '£$price',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )),
                  ),
                  Icon(
                    trailingIcon,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                ],
              ),
            ]),
      ),
    );
  }

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
                            Navigator.pop(context);
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
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignInScreen()),
                                  (route) => false);
                              print('Logout success');
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

  void pushToWhere() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SupportScreen()));
  }

  Widget getBody(User user) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: <Widget>[
              StreamBuilder<FoodTruck>(
                  stream: bloc.truckStream,
                  initialData: bloc.foodTruck,
                  builder: (context, snapshot) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      child: getTruckImage(snapshot.data),
                    );
                  }),
              Positioned(bottom: -40, left: 30, child: getProfilePic(user)),
              Positioned(
                right: 30.0,
                bottom: -40.0,
                child: Text(
                  user.firstName + " " + user.lastName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              )
            ],
          ),
          Container(
            height: 500,
            color: Colors.transparent,
            padding:
                EdgeInsets.only(top: 60.0, left: 8.0, right: 8.0, bottom: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StreamBuilder<FoodTruck>(
                            stream: bloc.truckStream,
                            initialData: bloc.foodTruck,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data.foodTruckName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              );
                            }),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2.0),
                          height: 20.0,
                          width: 90.0,
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0),
                              color: Colors.deepOrange),
                          child: Text(
                            'My Trucks >',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 18.0,
                              ),
                              StreamBuilder<FoodTruck>(
                                  stream: bloc.truckStream,
                                  initialData: bloc.foodTruck,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data.location == null
                                          ? "Location"
                                          : snapshot.data.location,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16.0),
                                    );
                                  }),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.grey,
                            onPressed: () {
                              gotoStallUpdate(
                                  bloc.foodTruckStreamController.value);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                divider(),
                listTile(
                    icon: Icons.account_box,
                    option: 'My Profile',
                    isEarning: false,
                    price: '',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: pushToNone),
                divider(),
                listTile(
                    icon: Icons.fastfood,
                    option: 'Orders',
                    isEarning: false,
                    price: '',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: ordersScreen),
                divider(),
                listTile(
                    icon: Icons.attach_money,
                    isEarning: true,
                    price: '168',
                    option: 'Earnings',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: pushToNone),
                divider(),
                listTile(
                    icon: Icons.home,
                    isEarning: false,
                    price: '',
                    option: 'Bank Details',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: pushToNone),
                divider(),
                listTile(
                    icon: Icons.track_changes,
                    isEarning: false,
                    price: '',
                    option: 'Change Password',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: changePassword),
                divider(),
                listTile(
                    icon: Icons.supervisor_account,
                    isEarning: false,
                    price: '',
                    option: 'Customer Support',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: pushToWhere),
                divider(),
                listTile(
                    icon: Icons.close,
                    isEarning: false,
                    price: '',
                    option: 'Logout',
                    trailingIcon: Icons.arrow_forward_ios,
                    yourFunction: onTapSubmitted),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getTruckImage(FoodTruck foodTruck) {
    if (foodTruck.images == null) {
      return Image.asset("assets/defaultFoodTruck.png", fit: BoxFit.cover);
    } else {
      return Image.network(
        foodTruck.images,
        fit: BoxFit.cover,
      );
    }
  }

  void ordersScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Orders()));
  }

  void changePassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChangePassword()));
  }

  void gotoStallUpdate(FoodTruck foodTruck) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => StallUpdate(foodTruck)));
  }

  Widget getProfilePic(User user) {
    return GestureDetector(
      onTap: () {
        changeProfilePic();
      },
      child: CircleAvatar(
        child: ClipOval(
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                height: 30,
                child: Container(
                  height: 20,
                  width: 30,
                  color: Color.fromRGBO(0, 0, 0, .74),
                  child: Center(
                    child: Icon(Icons.photo_camera, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        radius: 70.0,
        backgroundColor: Colors.white,
        backgroundImage: getProfileImage(user.profilePicUrl),
      ),
    );
  }

  void changeProfilePic() {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Change Image"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Camera"),
              onTap: () {
                openCamera();
              },
            ),
            ListTile(
              title: Text("Gallery"),
              onTap: () {
                openGallery();
              },
            )
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> openCamera() async {
    ImagePicker imagePicker = new ImagePicker();
    PickedFile _image = await imagePicker.getImage(source: ImageSource.camera);
    Fluttertoast.showToast(msg: "Updating Image");
    bloc.updateProfilePic(_image);
    Navigator.pop(context);
  }

  Future<void> openGallery() async {
    ImagePicker imagePicker = new ImagePicker();
    var _image = await imagePicker.getImage(source: ImageSource.gallery);
    Fluttertoast.showToast(msg: "Updating Image");
    bloc.updateProfilePic(_image);
    Navigator.pop(context);
  }

  void pushToNone() {
    Fluttertoast.showToast(msg: "To be added");
  }
}
