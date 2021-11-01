import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungrybuff/other/utils/styles.dart';
import 'package:hungrybuff/user/authentication/bloc/AuthenticationBLOC.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String tag = 'forgot';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthenticationBLOC authBloc = AuthenticationBLOC.getInstance();
  TextEditingController emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Reset Password')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 50.0),
              child: Container(
                  height: 99.3,
                  // width: 100.7,

                  child: Image.asset(
                    'assets/forgot/forgot_vector@3x.png',
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 30.0),
              child: Container(
                height: 37,
                //width: 229,
                child: Text(
                  'Forgot Password',
                  textAlign: TextAlign.left,
                  style: forgotStyle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 10.0),
              child: Center(
                child: Container(
                  height: 72,
                  //width: 229,
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        'Forgot your password? No worries. Enter your email address here to reset the password',
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 15.0),
              child: Container(
                height: 164,
                width: 315,
                child: Wrap(
                  children: <Widget>[_emailId(), _getSubmitButton()],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  final Color gradient1 = Color.fromRGBO(237, 74, 21, 1);

  final Color gradient2 = Color.fromRGBO(245, 116, 14, 1);

  TextStyle forgotStyle = new TextStyle(
      fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle greyStyle =
      new TextStyle(fontSize: 16.0, color: Color.fromRGBO(159, 159, 159, 1));

  TextStyle bStyle = new TextStyle(
      fontSize: 16.0,
      color: Color.fromRGBO(255, 255, 255, 1),
      fontWeight: FontWeight.bold);

  Widget _getSubmitButton() {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 55.0,
          child: RaisedButton(
            color: Colors.deepOrange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Sending reset email...')));

              String emailAddress = emailController.text;
              print(emailAddress);
              String email =
                  "A password reset email has been sent to $emailAddress";
              await authBloc
                  .resetPassword(emailAddress)
                  .then((value) => Navigator.pop(context, email))
                  .catchError((onError) => Navigator.pop(context, "Unable to send the password reset email, please try again later."));
              }
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Submit',
                    style: UtilStyles.whiteBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      );
    });
  }

  Widget _emailId() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (email) => FocusScope.of(context).nextFocus(),
        validator: (email) =>
            EmailValidator.validate(email) ? null : "Invalid email address",
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.black),
          border:
              new OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
