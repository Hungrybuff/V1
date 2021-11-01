import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Profile edit was called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage('assets/home/bg@3x.png'),
                        fit: BoxFit.fill),
                    color: Colors.purple)),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                children: <Widget>[
                  _FullNameField(),
                  TextFormField(),
                  TextFormField(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _FullNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        child: TextFormField(
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
