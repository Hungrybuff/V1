import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/styles.dart';
import 'package:hungrybuff/user/home/support/bloc/support_bloc.dart';

class SupportScreen extends StatelessWidget {
  static String tag = 'support-screen';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          margin: EdgeInsets.only(top: 60.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  alignment: Alignment(0.0, 0.0),
                  padding: EdgeInsets.only(
                    right: 260.0,
                  ),
                  child:
                      Text(SupportBloc.getTitle(), style: UtilStyles.boldBlack),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 120.00,
                  child: Image.asset(
                    'assets/support/support_vector.png',
                  ),
                ),
                Text(
                  SupportBloc.getHeading(),
                  style: UtilStyles.boldBlack,
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
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
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
}
