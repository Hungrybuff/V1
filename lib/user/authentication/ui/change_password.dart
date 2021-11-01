import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/colors.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  UtilColors uCol = new UtilColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 15.0),
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, right: 14.0, top: 15.0, bottom: 5.0),
                    child: Container(
                      height: 54.0,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Current Password',
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, right: 14.0, top: 15.0, bottom: 5.0),
                    child: Container(
                      height: 54.0,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'New Password',
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, right: 14.0, top: 15.0, bottom: 5.0),
                    child: Container(
                      height: 54.0,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Please enter your old password and'),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('New password to change the login password'),
                    ]),
              ],
            ),
          ]),
      bottomNavigationBar: gradientButton(),
    );
  }

  Widget gradientButton() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: 14.0, right: 14.0),
      child: InkWell(
        onTap: () {
          print("Password Updated");
        },
        child: Container(
          alignment: Alignment.center,
          height: 56.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient:
                  LinearGradient(colors: [uCol.gradient2, uCol.gradient1])),
          child: Text(
            "UPDATE PASSWORD",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 1.12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
      ),
    );
  }
}
