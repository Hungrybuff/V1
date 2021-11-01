import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/Authentication/UI/LoginScreen.dart';
import 'package:hungrybuff/owner/Authentication/UI/forgot_password.dart';
import 'package:hungrybuff/owner/Packages/support_screen.dart';
import 'package:hungrybuff/user/authentication/ui/login_screen.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmNewPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text('Change Password', style: changeStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (val) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Current Password',
                              hintStyle: hintStyle),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          controller: newPasswordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (val) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'New Password',
                              hintStyle: hintStyle),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          controller: confirmNewPasswordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              hintStyle: hintStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Please fill in your old password and',
                      style: hintStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'New Password to change your login password',
                        style: hintStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: InkWell(
                      onTap: () {
                        print('Yay! Password updated');
                        goToSupport(confirmNewPasswordController.text);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 54.0,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                                colors: [Colors.orange, Colors.deepOrange])),
                        child: Text(
                          'UPDATE PASSWORD',
                          style: updateStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToSupport(String password) async{
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Succesfull changed password");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) =>SignInScreen()), (route) => false);
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  void goToForgot() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  TextStyle updateStyle = new TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle hintStyle = new TextStyle(
      color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 16.0);

  TextStyle changeStyle = new TextStyle(
      color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold);
}
