import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:image_picker/image_picker.dart';

class StallUpdate extends StatefulWidget {
  final FoodTruck foodTruck;

  StallUpdate(this.foodTruck);

  @override
  _StallUpdateState createState() => _StallUpdateState();
}

class _StallUpdateState extends State<StallUpdate> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  FoodTruck foodTruck;
  PickedFile file;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.foodTruck = widget.foodTruck;
    nameController.value = TextEditingValue(
        text: foodTruck.foodTruckName == null ? "" : foodTruck.foodTruckName);
    descriptionController.value = TextEditingValue(
        text: foodTruck.description == null ? "" : foodTruck.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              fit: StackFit.loose,
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  height: 300,
                  child: getFoodTruckImage(),
                  width: double.infinity,
                ),
                getIcons(foodTruck.images)
              ],
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, bottom: 4.0),
                              child: Text(
                                'Stall Name',
                                style: tipStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 8.0),
                              height: 54.0,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.grey)),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none),
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, bottom: 4.0),
                              child: Text(
                                'Description',
                                style: tipStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 8.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.grey)),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLines: 10,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                OwnerHomeBloc.getInstance().updateFoodTruck(
                    nameController.text, descriptionController.text, file);
                Fluttertoast.showToast(msg: "Updating Food truck");
                Navigator.pop(context);
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 54.0,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient:
                    LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
              ),
              child: Text(
                'SAVE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getFoodTruckImage() {
    if (file == null) {
      return foodTruck.images == null
          ? Image.asset(
              "assets/defaultFoodTruck.png",
              fit: BoxFit.cover,
            )
          : Image.network(
              foodTruck.images,
              fit: BoxFit.cover,
            );
    } else {
      return Image.file(
        File(file.path),
        fit: BoxFit.cover,
      );
    }
  }

  Positioned getIcons(String url) {
    return Positioned(
      bottom: -17,
      right: 15,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          //border: Border.all(width: 5.0, color: Colors.transparent),
          borderRadius: BorderRadius.all(
              Radius.circular(13.0) //                 <--- border radius here
              ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  openCamera();
                },
              ),
              getVerticalDivider(),
              IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
                onPressed: () {
                  viewImage(url);
                },
              ),
              getVerticalDivider(),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  openGallery();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle tipStyle = new TextStyle(
      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal);

  TextStyle inStyle = new TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold);

  Widget getVerticalDivider() {
    return VerticalDivider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  Future<void> openCamera() async {
    ImagePicker imagePicker = new ImagePicker();
    var image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      file = image;
    });
  }

  Future<void> openGallery() async {
    ImagePicker imagePicker = new ImagePicker();
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      file = image;
    });
  }

  void viewImage(String url) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(content: getFoodTruckImage());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
