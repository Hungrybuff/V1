import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungrybuff/owner/Authentication/UI/sign_up_success.dart';

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool _value = false;
  bool _visible = true;
  bool _visibility = true;
  SizedBox space = new SizedBox(height: 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 64.0, bottom: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Create Account', style: createStyle),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Enter your details', style: greyStyle),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('First Name'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        controller: firstNameController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('Last Name'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        controller: lastNameController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('Email Id'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        controller: emailController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('Phone Number'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        controller: numberController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('Password'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        obscureText: _visible,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(_visible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Colors.deepOrange,
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                            )),
                      ),
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('Confirm Password'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        obscureText: _visibility,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(_visibility
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Colors.deepOrange,
                              onPressed: () {
                                setState(() {
                                  _visibility = !_visibility;
                                });
                              },
                            )),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.deepOrange,
                    value: _value,
                    onChanged: (val) {
                      onChange();
                    },
                    activeColor: Colors.white,
                  ),
                  Text(
                      'By signing up you are agreeing to the terms \n& conditions of HungryBuff'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 54.0,
                    decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange]),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Text(
                      'SIGN UP',
                      style: signUpStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account?', style: greyStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          print('Sign in page invoked');
                          goToSignIn();
                        },
                        child: Text(
                          'Click here to Sign in',
                          style: greyStyle2,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onChange() {
    setState(() {
      _value = !_value;
    });
  }

  void onTap() {
    if (_value == false) {
      print('Agree to create Account');
      Fluttertoast.showToast(msg: 'Please agree to the terms to Sign Up');
    } else {
      print('Create Account clicked Successfully');
      goToAccountCreated();
    }
  }

  void goToSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  void goToAccountCreated() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AccountCreated()));
  }

  TextStyle createStyle = new TextStyle(
      fontSize: 26.0, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle signUpStyle = new TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle greyStyle = new TextStyle(
    fontSize: 16.0,
    color: Colors.grey,
    fontWeight: FontWeight.normal,
  );

  TextStyle greyStyle2 = new TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline);
}
