import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 99.3,
                        child: Image.asset(
                          'assets/forgot/forgot_vector@3x.png',
                          fit: BoxFit.fill,
                        )),
                    Text(
                      'Forgot Password',
                      textAlign: TextAlign.left,
                      style: forgotStyle,
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          'Forgot your password? No worries.',
                          style: greyStyle,
                        ),
                        Text(
                          'Just enter the mobile number you used to',
                          style: greyStyle,
                        ),
                        Text(
                          "Sign up and we'll send you a link to reset it.",
                          style: greyStyle,
                        )
                      ],
                    ),
                    TextField(
                      controller: numberController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                        ),
                        border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                    InkWell(
                      onTap: () {
                        print('Number Submitted for OTP');
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 54.0,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: LinearGradient(
                                  colors: [gradient2, gradient1])),
                          child: Text(
                            'SUBMIT',
                            style: submitStyle,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ]),
      ),
    );
  }

  final Color gradient1 = Color.fromRGBO(237, 74, 21, 1);

  final Color gradient2 = Color.fromRGBO(245, 116, 14, 1);

  TextStyle forgotStyle = new TextStyle(
      fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle submitStyle = new TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle greyStyle =
      new TextStyle(fontSize: 16.0, color: Color.fromRGBO(159, 159, 159, 1));

  TextStyle bStyle = new TextStyle(
      fontSize: 16.0,
      color: Color.fromRGBO(255, 255, 255, 1),
      fontWeight: FontWeight.bold);
}
