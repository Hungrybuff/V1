import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BackendTestScreen extends StatefulWidget {
  @override
  _BackendTestScreenState createState() => _BackendTestScreenState();
}

class _BackendTestScreenState extends State<BackendTestScreen> {
  String functionName;
  String functionParams;

  TextEditingController functionParamsController = new TextEditingController();

  TextEditingController functionNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          new TextField(
            controller: functionNameController,
            decoration: InputDecoration(hintText: "Function name"),
          ),
          Expanded(
              child: new TextField(
            controller: functionParamsController,
            decoration: InputDecoration(hintText: "Function parameteres "),
            maxLines: 10,
          )),
          Row(
            children: <Widget>[
              Expanded(
                child: new RaisedButton(
                  onPressed: () => goToResultScreen(),
                  child: new Text("Confirm"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void goToResultScreen() {
    functionName = functionNameController.text;
    functionParams = functionParamsController.text;

    APICall apiCall = new APICall(functionName, functionParams);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext c) => BackendAPIResultScreen(apiCall)));
  }

  @override
  void initState() {
    FirebaseAuth.instance.signInAnonymously();
    super.initState();
  }
}

class APICall {
  String functionName;
  String functionParams;
  String response;

  APICall(this.functionName, this.functionParams);
}

class BackendAPIResultScreen extends StatefulWidget {
  final APICall apiCall;

  BackendAPIResultScreen(this.apiCall);

  @override
  _BackendAPIResultScreenState createState() => _BackendAPIResultScreenState();
}

class _BackendAPIResultScreenState extends State<BackendAPIResultScreen> {
  String data = "";
  int i = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.refresh), onPressed: () => getData())
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(data),
    );
  }

  void getData() {
//    FirebaseDatabase.instance.reference().child("test").set("working");
    print(widget.apiCall.functionName);
    if (widget.apiCall.functionParams == null ||
        widget.apiCall.functionParams.length == 0)
      CloudFunctions.instance
          .getHttpsCallable(functionName: widget.apiCall.functionName)
          .call()
          .then((value) => onData(value));
    else
      CloudFunctions.instance
          .getHttpsCallable(functionName: widget.apiCall.functionName)
          .call(widget.apiCall.functionParams)
          .then((value) => onData(value));
  }

  void onData(HttpsCallableResult value) {
    setState(() {
      data = value.data.toString();
    });
  }
}
