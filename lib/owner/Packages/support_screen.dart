import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  static String tag = 'support-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support"),
      ),
      body: Container(
          //  margin: EdgeInsets.only(top: 60.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Image.asset(
              'assets/support/support_vector.png',
            ),
            Text(
              'Get Support',
              style: bigBlack,
            ),
            Container(
              padding: EdgeInsets.only(left: 45.0, right: 45.0),
              alignment: Alignment(0.0, 0.0),
              child: Text(
                'For any support request your regards your orders or deliveries please feel free to speak with us at below',
                textAlign: TextAlign.center,
                maxLines: 3,
                softWrap: true,
                textDirection: TextDirection.ltr,
                style: normalGrey,
              ),
            ),
            Column(
              children: <Widget>[
                Text('Call us - +91 9985189270'),
                Text('Mail us - support@hungrybuff.co')
              ],
            ),
          ])),
    );
  }

  final TextStyle boldBlack = new TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0);

  final TextStyle bigBlack = new TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0);

  final TextStyle normalGrey = new TextStyle(
      color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 16.0);
}
