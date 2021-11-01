import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungrybuff/owner/admin/AdminBloc.dart';

class AddNewFoodTruck extends StatefulWidget {
  final String ownerId;
  AddNewFoodTruck(this.ownerId);

  @override
  _AddNewFoodTruckState createState() => _AddNewFoodTruckState();
}

class _AddNewFoodTruckState extends State<AddNewFoodTruck> {
  TextEditingController truckNameController = new TextEditingController();

  TextEditingController descriptionController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AdminBloc bloc = AdminBloc().getInstance();
  TextEditingController fromTimeController = new TextEditingController();
  TextEditingController toTimeController = new TextEditingController();
  TimeOfDay toTime;
  TimeOfDay fromTime;

  @override
  void initState() {
    super.initState();
    print("OwnerId:" + widget.ownerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Add Food Truck"),
      ),
      body: buildBody(),
    );
  }

  Widget listOfUser(QuerySnapshot data) {
    if (data.documents.length == 0)
      return new Text("No data");
    else
      return new ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(data.documents[index].data.toString()),
          ));
        },
        itemCount: data.documents.length,
      );
  }

  Widget getTextField(String title, TextEditingController controller,
      TextInputType inputType, int maxLines) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(title),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepOrangeAccent)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    keyboardType: inputType,
                    textInputAction: TextInputAction.next,
                    controller: controller,
                    maxLines: maxLines,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField(
                "Truck Name", truckNameController, TextInputType.text, 1),
            getTextField(
                "description", descriptionController, TextInputType.text, 5),
            getFromTime(),
            getToTime(),
            getButton(),
          ],
        ),
      ),
    );
  }

  Widget getButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.deepOrangeAccent,
            child: Text(
              "Add Truck",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                showFlutterToast("Adding Food Truck");
                bloc.addFoodTruck(
                    truckNameController.text,
                    descriptionController.text,
                    widget.ownerId,
                    getTimeInSeconds(fromTime),
                    getTimeInSeconds(toTime));
                showFlutterToast("Added Food Truck Successfully");
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Input Error"),
      content: Text("Please select owner"),
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

  void showFlutterToast(String text) {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_LONG);
  }

  Widget getFromTime() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          final dateTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 0, minute: 0),
          );
          setState(() {
            fromTime = dateTime;
            fromTimeController.value = new TextEditingValue(
                text: dateTime.hour.toString() +
                    ":" +
                    dateTime.minute.toString());
          });
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: fromTimeController,
            validator: (val) {
              if (val.isEmpty) return "Select time";
              return null;
            },
            decoration: InputDecoration(
              labelText: "From time",
              icon: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.deepOrangeAccent,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget getToTime() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          final dateTime = await showTimePicker(
              context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
          setState(() {
            toTime = dateTime;
            toTimeController.value = new TextEditingValue(
                text: dateTime.hour.toString() +
                    ":" +
                    dateTime.minute.toString());
          });
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: toTimeController,
            validator: (val) {
              if (val.isEmpty) return "Select time";
              return null;
            },
            decoration: InputDecoration(
              labelText: "To time",
              icon: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.deepOrangeAccent,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  double getTimeInSeconds(TimeOfDay time) {
    if (time.hour > 0)
      return (time.hour * 60 * 60).toDouble();
    else
      return (time.minute * 60).toDouble();
  }
}
