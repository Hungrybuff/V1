import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungrybuff/model/user_details.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/other/utils/styles.dart';
import 'package:hungrybuff/user/Authentication/bloc/AuthenticationBLOC.dart';
import 'package:hungrybuff/user/Authentication/ui/SplashScreen.dart';
import 'package:hungrybuff/user/Authentication/ui/login_screen.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static String tag = 'Signup';

  final _formKey = GlobalKey<FormState>();
  String dropValue = '+91';
  String error = 'Please enter valid credentials';
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController phoneNumController = new TextEditingController();
  UtilColors uColors = new UtilColors();
  int currentState = USER_DETAILS_STATE;
  static const int USER_DETAILS_STATE = 0;
  static const int OTP_STATE = 1;
  static const int SUCCESS_STATE = 2;
  static const int LOADING_STATE = 3;
  AuthenticationBLOC authBloc = AuthenticationBLOC.getInstance();

  String _phoneNumber;

  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  Widget showUserDetails() {
    return ListView(children: <Widget>[
      Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createAcc(),
            _enterDet(),
            _firstName(),
            _lastName(),
            _emailId(),
            _phoneNum(),
            _password(),
            _confirmPassword(),
            _checkBox(),
            _getSignUpButton(),
            _alreadyHaveAcc(),
            _getClickHere(),
          ],
        ),
      ),
      Container(alignment: Alignment.bottomCenter, child: _getBottom()),
    ]);
  }

  Widget _createAcc() {
    return Container(
      padding: EdgeInsets.only(top: 60.0, left: 20.0),
      child: Text(
        'Create Account',
        style: UtilStyles.createAcc,
      ),
    );
  }

  Widget _enterDet() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 15.0),
      child: Text(
        'Enter your details',
        style: UtilStyles.enterDet,
      ),
    );
  }

  Widget _firstName() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
        validator: (val) =>
            firstNameController.text.isEmpty ? 'Enter First Name' : null,
        autocorrect: false,
        autofocus: false,
        controller: firstNameController,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        decoration: InputDecoration(
          labelText: 'First Name',
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

  Widget _lastName() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        controller: lastNameController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
        validator: (String val) => val.isEmpty ? 'Enter last Name' : null,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        decoration: InputDecoration(
          labelText: 'Last Name',
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

  Widget _emailId() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
        validator: (val) => val.isEmpty ? 'Enter an Email Id' : null,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
          labelText: 'Email ID',
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

  Widget _phoneNum() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        controller: phoneNumController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
        validator: (val) => val.isEmpty ? 'Enter your Phone Number' : null,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: DropdownButton<String>(
              elevation: 10,
              autofocus: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              isDense: false,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
              value: dropValue,
              onChanged: (String newValue) {
                setState(() {
                  dropValue = newValue;
                });
              },
              items: <String>[
                '+91',
                '+44',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          labelText: 'Phone Number',
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

  Widget _password() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
        controller: passwordController,
        validator: (val) => passwordController.text.length < 6
            ? 'Password must contain 6 characters'
            : null,
        autocorrect: false,
        autofocus: false,
        obscureText: _isPasswordObscure,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              color: Colors.deepOrange,
              icon: Icon(_isPasswordObscure == true
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isPasswordObscure = !_isPasswordObscure;
                });
              }),
          labelText: 'Password',
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

  Widget _confirmPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
        validator: (val) =>
            confirmPasswordController.text != passwordController.text
                ? 'Password and confirm password should be same'
                : null,
        controller: confirmPasswordController,
        autocorrect: false,
        autofocus: false,
        obscureText: _isConfirmPasswordObscure,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              color: Colors.deepOrange,
              icon: Icon(_isConfirmPasswordObscure == true
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                });
              }),
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: Colors.black),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(),
              borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _checkBox() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
      child: Row(children: <Widget>[
        Checkbox(
          value: checked,
          onChanged: (val) {
            checked = val;
          },
        ),
        Container(
          child: Text(
            'By signing up you are agreeing to all the terms & \nconditions of HungryBuff',
            overflow: TextOverflow.clip,
            maxLines: 2,
            softWrap: false,
          ),
        ),
      ]),
    );
  }

  Widget _getSignUpButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Container(
            height: 55.0,
            child: RaisedButton(
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: checked
                  ? () async {
                      if (_formKey.currentState.validate()) {
                        String emailAddress = emailController.text;
                        String phoneNumber = phoneNumController.text;
                        String firstName = firstNameController.text;
                        String lastName = lastNameController.text;
                        phoneNumber = dropValue + phoneNumber;
                        UserDetails userDetails = new UserDetails(
                            firstName, lastName, phoneNumber, emailAddress);
                        authBloc.createNewUser(
                            navigateToSplashScreen: pushToSplash,
                            alreadyExistingUser: showExistingUserError,
                            navigateToOTPScreen: goToOTPScreen,
                            passwordIsWeak: showPasswordIsWeakDialog,
                            userDetails: userDetails,
                            password: passwordController.text,
                            error: showError,
                            loading: showLoading);
                      }
                    }
                  : null,
              child: Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Text(
                    'SIGN UP',
                    style: UtilStyles.whiteBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              ]),
            )),
      ),
    ]);
  }

  Widget _alreadyHaveAcc() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      alignment: Alignment.center,
      child: Text('Already have an account?'),
    );
  }

  Widget _getClickHere() {
    return Container(
      padding: EdgeInsets.only(top: 5.0 * 2),
      alignment: Alignment(0.0, 0.0),
      child: InkWell(
        onTap: () {
          print('click to sign up is clicked');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Text(
          'Click here to Sign In',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              fontFamily: 'MontSerrat',
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _getBottom() {
    return Container(
      height: 120.0,
      padding: EdgeInsets.only(top: 20.0),
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/login/bg@3x@3x.png',
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  void pushLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void showPasswordIsWeakDialog() {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text('Password entered is weak!'),
      elevation: 10.0,
      duration: Duration(milliseconds: 5000),
      action: SnackBarAction(
          label: 'Okay!',
          onPressed: () {
            print('Snackbar pressed');
          }),
    ));
  }

  void showError(String error) {
    print("Show error");
    showPopUP(context, error);
  }

  void showExistingUserError() {
    SnackBar(
        content: Text(
      'User already exists',
    ));
  }

  void goToOTPScreen(UserDetails userDetails) {
    this._phoneNumber = userDetails.phoneNumber;
    setState(() {
      currentState = OTP_STATE;
    });
  }

  void showLoading() {
    CircularProgressIndicator();
  }

  Widget getBody() {
    switch (currentState) {
      case USER_DETAILS_STATE:
        return showUserDetails();
      case OTP_STATE:
        return buildOTP();
    }
    return new Text("Error");
  }

  Widget buildOTP() {
    return Column(
      children: <Widget>[
        Expanded(
            child: SingleChildScrollView(child: Center(child: buildBody()))),
        buildSubmit()
      ],
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 30.0, top: 122.0),
          child: Container(
            height: 120,
            width: 94.9,
            child: Image.asset(
              'assets/verify/otp_vector@3x.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, top: 60.0),
          child: Text(
            'Verify OTP',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, top: 15.0),
          child: Text(
            'We sent you a code to verify your',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, top: 5.0, bottom: 25.0),
          child: Text(
            'phone number $_phoneNumber',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
        buildOTPField(context),
        resend(),
      ],
    );
  }

  Widget resend() {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, top: 5.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: InkWell(
            onTap: () {
              String emailAddress = emailController.text;
              String phoneNumber = phoneNumController.text;
              String firstName = firstNameController.text;
              String lastName = lastNameController.text;
              phoneNumber = dropValue + phoneNumber;
              UserDetails userDetails = new UserDetails(
                  firstName, lastName, phoneNumber, emailAddress);
              authBloc.createNewUser(
                  navigateToSplashScreen: pushToSplash,
                  alreadyExistingUser: showExistingUserError,
                  navigateToOTPScreen: goToOTPScreen,
                  passwordIsWeak: showPasswordIsWeakDialog,
                  userDetails: userDetails,
                  password: phoneNumber,
                  error: showError,
                  loading: showLoading);
            },
            child: Text('Resend',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(237, 74, 21, 1)))),
      ),
    );
  }

  void showPopUP(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text(text),
            actions: <Widget>[
              Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: new RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Okay",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget buildSubmit() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
      child: Container(
        height: 56.4,
        decoration: new BoxDecoration(
            gradient:
                LinearGradient(colors: [uColors.gradient2, uColors.gradient1]),
            borderRadius: BorderRadius.circular(15.0)),
        child: Center(
          child: Text(
            'SUBMIT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOTPField(BuildContext context) {
    return PinEntryTextField(
      fields: 6,
      showFieldAsBox: true,
      onSubmit: (String pin) {
        AuthenticationBLOC.getInstance().onOTPSubmit(
            pin: pin,
            wrongOTP: showWrongOTP,
            navigateToSplashScreen: pushToSplash,
            error: showError);
      }, // end onSubmit
    );
  }

  void pushToSplash() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (Route<dynamic> route) => false);
  }

  void showWrongOTP() {
    showPopUP(context, 'You have entered the wrong otp');
  }
}
