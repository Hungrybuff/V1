import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:image_picker/image_picker.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen();

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static var types = ['Veg', 'Non-Veg'];
  var currentItemSelected = 'Veg';
  OwnerHomeBloc homeBloc;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController subTitleController = new TextEditingController();
  TextEditingController tagController = new TextEditingController();
  PickedFile file;

  final _formKey = GlobalKey<FormState>();

  bool isSpice = false;

  String foodCategory = "veg";

  String spice = "medium";

  bool nuts = false;

  String selectedSubTitle = "-----Select-----";

  @override
  void initState() {
    super.initState();
    homeBloc = OwnerHomeBloc.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          DropdownButton<String>(
            items: types.map((String dropDownItem) {
              return DropdownMenuItem<String>(
                value: dropDownItem,
                child: Text(
                  dropDownItem,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            value: currentItemSelected,
            onChanged: (String newSelectedValue) {
              currentItemSelected = newSelectedValue;
              print('switch case worked');
              onChange(newSelectedValue);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          print('Menu FAB pressed');
          onFabClick();
        },
        elevation: 5.0,
        tooltip: 'Add a new item',
        child: Container(
            alignment: Alignment.center,
            child: Text(
              '+',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("trucks")
            .document(homeBloc.foodTruckID)
            .collection("items")
            .snapshots(),
        builder: (context, snapshot) {
          print("Snapshot.data:"+snapshot.data.toString());
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.connectionState != ConnectionState.active)
            return new CircularProgressIndicator();
          print(snapshot.data.documents.length.toString());
          if (snapshot.data.documents.length < 1)
            return Center(child: new Text("No food items added!"));
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return listTile(
                  FoodItem.fromJson(snapshot.data.documents[index].data),
                  homeBloc.foodTruckID,
                  snapshot.data.documents[index].documentID);
            },
          );
        });
  }

  Widget listTile(FoodItem foodItem, String truckID, String itemID) {
    print("Food Item:"+foodItem.toString());
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          onTap: () => onTileClicked(foodItem, truckID, itemID),
          onLongPress: () => _showDialog(foodItem, itemID, truckID),
          leading: Container(
            height: 45.0,
            width: 45.0,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: NetworkImage(
                        foodItem.dishPic == null ? '' : foodItem.dishPic),
                    fit: BoxFit.fill)),
          ),
          title: Text(
            '£${foodItem.price}',
            style: TextStyle(
                color: Colors.green,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            foodItem.dishName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
          trailing: Switch(
            activeColor: Colors.white,
            activeTrackColor: Color.fromRGBO(76, 217, 100, 1),
            value: foodItem.isAvailable,
            onChanged: (val) async {
              foodItem.isAvailable = val;
              await Firestore.instance
                  .collection("trucks")
                  .document(truckID)
                  .collection("items")
                  .document(itemID)
                  .updateData({"isAvailable": foodItem.isAvailable});
            },
          ),
        ),
      ),
    );
  }

  void _showDialog(FoodItem foodItem, String itemID, String truckID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Item"),
          content: new Text("Do you want to delete the Menu Item"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                await Firestore.instance
                    .collection("trucks")
                    .document(truckID)
                    .collection("items")
                    .document(itemID)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*Widget buildNonVegItemTile(FoodItem foodItem, String truckID, String itemID) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Container(
        alignment: Alignment.center,
        height: 90.0,
        width: double.infinity,
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey, width: 0.3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              foodItem.dishPic == null ? '' : foodItem.dishPic),
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '£${foodItem.price}',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          foodItem.dishName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromRGBO(76, 217, 100, 1),
                  value: foodItem.isAvailable,
                  onChanged: (val) {
                    foodItem.isAvailable = val;
                    Firestore.instance
                        .collection("trucks")
                        .document(truckID)
                        .collection("items")
                        .document(itemID)
                        .updateData({"isAvailable": foodItem});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }*/

  void onChange(String newSelectedValue) {
    currentItemSelected = newSelectedValue;
  }

  void onFabClick() {
    file = null;
    showSheet(homeBloc.currentUser);
  }

  void onTileClicked(FoodItem item, String truckID, String itemID) {
    file = null;
    showSheet(homeBloc.currentUser,
        item: item, truckID: truckID, itemID: itemID);
  }

  void showSheet(FirebaseUser currentUser,
      {FoodItem item, String truckID, String itemID}) {
     nameController = new TextEditingController();
     descriptionController = new TextEditingController();
     priceController = new TextEditingController();
    subTitleController = new TextEditingController();
    tagController = new TextEditingController();
    OwnerHomeBloc homeBloc = OwnerHomeBloc.getInstance();
    isSpice = false;
    foodCategory = "veg";
    spice = "medium";
    selectedSubTitle = null;

    nuts = false;

    if(item!=null){
      nameController.value = new TextEditingValue(text: item.dishName);
      priceController.value = new TextEditingValue(text: item.price.toString());
      subTitleController.value = new TextEditingValue(text: item.subTitle);
      descriptionController.value = new TextEditingValue(text: (item.description ?? ""));
      tagController.value = new TextEditingValue(text: (item.tags ?? ""));
    }


    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setStateSheet /*You can rename this!*/) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, right: 8.0, left: 8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Create Dish Menu',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                getTextFormField(
                                    "Dish Name",
                                    "Enter the name of the dish",
                                    nameController,
                                    TextInputType.text),
                                getDropDown(setStateSheet),
                                getText(),
                                getTextFormField(
                                    "Sub Title",
                                    "Enter dish subtitle",
                                    subTitleController,
                                    TextInputType.text,
                                    setStateSheet),
                                getTextFormField(
                                    "Description",
                                    "Enter dish description",
                                    descriptionController,
                                    TextInputType.text),
                                getTextFormField(
                                    "Price",
                                    "Enter price of the dish (Ex:165)",
                                    priceController,
                                    TextInputType.number),
                                getFoodCategory(setStateSheet),
                                getSpicyQuantity(setStateSheet),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CheckboxListTile(
                                    onChanged: (bool value) {
                                      setStateSheet(() {
                                        nuts = value;
                                      });
                                    },
                                    value: nuts,
                                    title: Text("Nuts"),
                                  ),
                                ),
                                getNutsField(context, tagController),
                                getFoodImage(item),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 12.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState.validate()) {
                                        if(item==null && file==null){
                                          showAlertDialog(context,"Alert!","Please upload a food item image");
                                        }
                                      }
                                      if (itemID == null) {
                                        await addNewFoodItem(
                                            homeBloc,
                                            nameController,
                                            priceController,
                                            tagController,
                                            subTitleController,
                                            descriptionController,
                                            context);
                                      } else {
                                        updateExistingFoodItem(
                                            nameController,
                                            item,
                                            priceController,
                                            homeBloc,
                                            tagController,
                                            subTitleController,
                                            descriptionController,
                                            itemID,
                                            truckID,
                                            context);
                                      }
                                    },
                                    child: Container(
                                      height: 56.0,
                                      decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          gradient: LinearGradient(colors: [
                                            Colors.deepOrangeAccent,
                                            Colors.deepOrange
                                          ])),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  )));
        });
      },
    );
  }

  void updateExistingFoodItem(
      TextEditingController nameController,
      FoodItem item,
      TextEditingController priceController,
      OwnerHomeBloc homeBloc,
      TextEditingController tagController,
      TextEditingController subTitleController,
      TextEditingController descriptionController,
      String itemID,
      String truckID,
      BuildContext context) {
    FoodItem foodItem = FoodItem(
        nameController.text,
        item.dishPic,
        double.parse(priceController.text),
        foodCategory,
        homeBloc.foodTruckID,
        "",
        spice,
        nuts,
        tagController.text,
        selectedSubTitle == null ? subTitleController.text : selectedSubTitle,
        descriptionController.text);
    homeBloc.updateItem(foodItem, itemID, truckID);
    homeBloc.updateFoodTruckSubTitles(
        subTitleController.text == null || subTitleController.text.length == 0
            ? selectedSubTitle
            : subTitleController.text);
    Navigator.pop(context);
  }

  Future addNewFoodItem(
      OwnerHomeBloc homeBloc,
      TextEditingController nameController,
      TextEditingController priceController,
      TextEditingController tagController,
      TextEditingController subTitleController,
      TextEditingController descriptionController,
      BuildContext context) async {
    String url = await homeBloc.uploadImage(file);
    FoodItem foodItem = FoodItem(
        nameController.text,
        url,
        double.parse(priceController.text),
        foodCategory,
        homeBloc.foodTruckID,
        "",
        spice,
        nuts,
        tagController.text,
        subTitleController.text,
        descriptionController.text);
    homeBloc.addItem(foodItem);
    Navigator.pop(context);
    print(homeBloc.foodTruckID == null ? "NUll" : homeBloc.foodTruckID);
  }

  Widget getFoodImage(FoodItem item) {
    return item == null
        ? Container(
            height: 100,
            child: Center(
              child: file == null
                  ? FlatButton(
                      onPressed: () {
                        showAlertDialogForImageOptions();
                      },
                      child: Text("Upload Image"))
                  : Image.file(File(file.path)),
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 100, child: Image.network(item.dishPic)),
            ),
          );
  }

  Padding getNutsField(
      BuildContext context, TextEditingController tagController) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        decoration: new BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: TextField(
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: 'Tags',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
          maxLines: 1,
          onSubmitted: (val) => FocusScope.of(context).nextFocus(),
          controller: tagController,
        ),
      ),
    );
  }

  Column getSpicyQuantity(StateSetter setStateSheet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Spice",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Radio(
                  value: "high",
                  groupValue: spice,
                  onChanged: (String value) {
                    setStateSheet(() {
                      spice = value;
                      print(spice);
                    });
                  },
                ),
                Text("High"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "medium",
                  groupValue: spice,
                  onChanged: (String value) {
                    setStateSheet(() {
                      spice = value;
                      print(spice);
                    });
                  },
                ),
                Text("Medium"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "low",
                  groupValue: spice,
                  onChanged: (String value) {
                    setStateSheet(() {
                      spice = value;
                      print(spice);
                    });
                  },
                ),
                Text("Low"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column getFoodCategory(StateSetter setStateSheet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Food Category",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Radio(
                  value: "veg",
                  groupValue: foodCategory,
                  onChanged: (String value) {
                    setStateSheet(() {
                      foodCategory = value;
                      print(foodCategory);
                    });
                  },
                ),
                Text("Veg"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "vegan",
                  groupValue: foodCategory,
                  onChanged: (String value) {
                    setStateSheet(() {
                      foodCategory = value;
                      print(foodCategory);
                    });
                  },
                ),
                Text("Vegan"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "nonVeg",
                  groupValue: foodCategory,
                  onChanged: (String value) {
                    setStateSheet(() {
                      foodCategory = value;
                      print(foodCategory);
                    });
                  },
                ),
                Text("Non-Veg"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Padding getTextFormField(String labelText, String hintText,
      TextEditingController controller, TextInputType inputType,
      [StateSetter setStateSheet]) {
    print("Selected Sub Title:" + selectedSubTitle.toString());
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        enabled: labelText == "Sub Title"
            ? (selectedSubTitle == null ||
                selectedSubTitle.length == 0 ||
                selectedSubTitle == "-----Select-----")
            : true,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          hintText: hintText,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.orangeAccent,
              width: 1.0,
            ),
          ),
        ),
        controller: controller,
        onFieldSubmitted: (val) {
          if (labelText == "Sub title")
            setStateSheet(() {
              selectedSubTitle = null;
            });
          setState(() {
            selectedSubTitle = null;
          });
        },
        validator: (value) {
          if (labelText == "Dish Name" || labelText == "Price") {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }
          else if(labelText=="Sub Title"){
            if(selectedSubTitle==null){
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }
          }
          return null;
        },
      ),
    );
  }

  Future<void> showAlertDialogForImageOptions() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Image from"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Text("Camera"),
                    onTap: () => pickImageFromGallery(ImageSource.camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Text("Gallery"),
                    onTap: () => pickImageFromGallery(ImageSource.gallery),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void pickImageFromGallery(ImageSource source) async {
    final picker = new ImagePicker();
    final PickedFile pickedFile = await picker.getImage(source: source);
    setState(() {
      file = pickedFile;
    });
    Navigator.pop(context);
    print(pickedFile.path.toString());
  }

  Widget getDropDown(StateSetter sheetSetState) {
    List<String> list = homeBloc.foodTruckStreamController.value.subTitles;
    if (list == null || list.length == 0) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<FoodTruck>(
              stream: homeBloc.truckStream,
              builder: (context, snapshot) {
                List<String> snapList = snapshot.data == null
                    ? new List()
                    : snapshot.data.subTitles;
                List<String> list = new List();
                list.add("-----Select-----");
                list.addAll(snapList);
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: new DropdownButton<String>(
                          value: selectedSubTitle,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select Sub title"),
                          ),
                          items: list.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            sheetSetState(() {
                                selectedSubTitle = value;
                              print("SubTitle Controller text:" +
                                  subTitleController.text);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      );
    }
  }

  Widget getText() {
    if (homeBloc.foodTruckStreamController.value.subTitles == null ||
        homeBloc.foodTruckStreamController.value.subTitles.length == 0) {
      return Container();
    } else {
      return Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          "OR",
          style: TextStyle(fontSize: 12),
        ),
      ));
    }
  }

 void showAlertDialog(BuildContext context,String title,String msg) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
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
}
