import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int phoneNumber = 9985189270;
  double timer = 2.59;

  TextEditingController firstNum = new TextEditingController();
  TextEditingController secondNum = new TextEditingController();
  TextEditingController thirdNum = new TextEditingController();
  TextEditingController fourthNum = new TextEditingController();

  String otp = '';

  void otpSubmitted() {
    setState(() {
      otp = firstNum.text + secondNum.text + thirdNum.text + fourthNum.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Container(
                        height: 110.0,
                        child: Image.asset(
                          'assets/otp/otp_vector2.png',
                          fit: BoxFit.fill,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Verify OTP',
                      style: verifyStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'We sent you a code to verify your \nphone number $phoneNumber ',
                          style: greyStyle,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 56.4,
                        width: 56.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          controller: firstNum,
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          // onSubmitted: (val) => FocusScope.of(context).nextFocus(),
                          onChanged: (val) =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 56.4,
                        width: 56.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          controller: secondNum,
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          onChanged: (val) =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 56.4,
                        width: 56.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          controller: thirdNum,
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          onChanged: (val) =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 56.4,
                        width: 56.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey)),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fourthNum,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (val) => otpSubmitted(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$timer'),
                        InkWell(
                            onTap: () {
                              print('Resend OTP');
                            },
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: InkWell(
                      onTap: () {
                        print('OTP Submitted');
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 56.4,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange])),
                          child: Text(
                            'SUBMIT',
                            style: submitStyle,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          )
        ],
      ),
    );
  }

  TextStyle verifyStyle = new TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      letterSpacing: 1.0);

  TextStyle greyStyle = new TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  TextStyle submitStyle = new TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
}
