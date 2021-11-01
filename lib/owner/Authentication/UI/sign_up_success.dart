import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'change_password.dart';

class AccountCreated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void goToHome() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChangePassword()));
    }

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage(
                          'assets/signup/bg_order@3x.png',
                        ),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                          height: 90.0,
                          width: 90.0,
                          child: Image.asset(
                            'assets/signup/logo.png',
                            fit: BoxFit.fill,
                          )),
                      Image.asset('assets/signup/confirm_tick_order.png'),
                      Container(
                        alignment: Alignment.center,
                        height: 35.0,
                        width: 150.0,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          'Awesome',
                          style: aweStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Thank you for registering',
                              style: whiteStyle,
                            ),
                            Text(
                              'with us!',
                              style: whiteStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'We will activate your account in',
                            style: activateStyle,
                          ),
                          Text(
                            '3-4 business days',
                            style: activateStyle,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          print('Done clicked on Account created screen');
                          goToHome();
                          //push to home screen here
                        },
                        child: Container(
                          height: 35.0,
                          width: 120.0,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.deepOrange),
                          child: Text(
                            'Done',
                            style: doneStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  final TextStyle aweStyle = new TextStyle(
      color: Colors.deepOrange, fontSize: 18.0, fontWeight: FontWeight.bold);

  final TextStyle whiteStyle = new TextStyle(
      color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold);

  final TextStyle activateStyle = new TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  final TextStyle doneStyle = new TextStyle(
      color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w500);
}
