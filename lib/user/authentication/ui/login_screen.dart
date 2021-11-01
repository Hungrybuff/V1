import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/styles.dart';
import 'package:hungrybuff/user/Authentication/ui/SplashScreen.dart';
import 'package:hungrybuff/user/Authentication/ui/forgot_password.dart';
import 'package:hungrybuff/user/Authentication/ui/sign_up.dart';
import 'package:hungrybuff/user/authentication/bloc/AuthenticationBLOC.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordObscure = true;
  bool _showMessage = false;
  String _message = '';
  static final loginController = TextEditingController();
  static final passwordController = TextEditingController();
  AuthenticationBLOC authBloc = AuthenticationBLOC.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                myWidget(),
                Container(
                    padding: EdgeInsets.only(top: 70.0), child: _getWelcome()),
                _mobileNumField(),
                _passwordField(),
                _getForgotText(),
                _getLoginButton(),
              //  _getConnectButton(), TODO: Facebook Integration
                _getDone(),
                _getClickHere(),
                Container(
                    alignment: Alignment.bottomCenter, child: _getBottom())
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _getWelcome() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 20.0),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(text: 'Welcome to', style: UtilStyles.generalBold),
        TextSpan(text: ' HungryBuff', style: UtilStyles.loginBlack)
      ])),
    );
  }

  Widget _mobileNumField() {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
          child: TextFormField(
            autocorrect: false,
            controller: loginController,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal()),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.blue),
              ),
            ),
          ),
        ));
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 30.0 / 2, top: 20.0),
        child: TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.next,
          obscureText: _isPasswordObscure,
          autocorrect: false,
          autofocus: false,
          onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              alignment: Alignment.center,
              icon: Icon(
                  _isPasswordObscure ? Icons.visibility_off : Icons.visibility),
              color: Colors.deepOrange,
              onPressed: () {
                setState(() {
                  _isPasswordObscure = !_isPasswordObscure;
                });
              },
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.horizontal(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1, //                   <--- border width here
      ),
    );
  }

  Widget myWidget() {
    return Visibility(
      visible: _showMessage,
      child: Container(
        margin: const EdgeInsets.all(30.0),
        padding: const EdgeInsets.all(10.0),
        decoration: myBoxDecoration(), //             <--- BoxDecoration here
        child: Text(
          _message,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  Widget _getForgotText()  {
    return Container(
        padding: EdgeInsets.only(top: 10.0 * 1.5, bottom: 15.0),
        alignment: Alignment(0.85, 0.0),
        child: InkWell(
          child: Text(
            'Forgot Password?',
            style: UtilStyles.generalText,
          ),
          onTap: () async {

          final result  = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen()));
            if (result != null){
              setState(() {
                _showMessage = true;
                _message = result as String;
              });
            }
          },
        ));
  }

  Widget _getLoginButton() {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
          height: 55.0,
          child: RaisedButton(
            color: Colors.deepOrange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () async {
              String emailAddress = loginController.text;
              String password = passwordController.text;
              await authBloc.login(
                email: emailAddress,
                password: password,
                loginSuccessGoToSplash: loginSuccessGoTOSplash,
                wrongCombination: wrongPassword,
                noUserWithThisEmailAddress: noUserExists,
              );
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'SIGN IN',
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

  Widget _getConnectButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 54.4,
        width: double.infinity,
        child: InkWell(
          onTap: () {
            print('connect to fb clicked');
            /*     Navigator.push(context,
                MaterialPageRoute(builder: (context) => EnableLocation()));*/
          },
          child: Image.asset('assets/login/fb_btn@3x.png',
              fit: BoxFit.fitWidth, width: 110.0, height: 110.0),
        ),
      ),
    );
  }

  Widget _getDone() {
    return Container(
        padding: EdgeInsets.only(top: 5.0 * 2),
        child: Text(
          'Dont have an account?',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontFamily: 'MontSerrat',
              fontWeight: FontWeight.w500),
        ));
  }

  Widget _getClickHere() {
    return Container(
      padding: EdgeInsets.only(top: 5.0 * 3),
      child: InkWell(
        onTap: () {
          print('click to sign up is clicked');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          'Click here to Sign Up',
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

  void loginSuccessGoTOSplash() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext c) => SplashScreen()));
  }

  void wrongPassword() {
    print("wrong password called");
    showPopUP(context, "Check details entered");
  }

  void noUserExists() {
    print("showing dialog");
    showPopUP(context, "No user with this email");
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
}
