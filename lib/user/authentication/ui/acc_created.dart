import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/user/order_tracking/allordersScreen/all_orders.dart';

class OrderCreated extends StatefulWidget {
  OrderCreated({this.getFirebaseUser, this.orderRef});

  final FirebaseUser getFirebaseUser;
  final String orderRef;

  @override
  _OrderCreatedState createState() => _OrderCreatedState();
}

class _OrderCreatedState extends State<OrderCreated> {
  final FlareControls animationControls = FlareControls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Placed")),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Your Order Reference is:",
                            style: TextStyle(inherit: true)),
                        Text(widget.orderRef,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        textColor: Color(0xFF6200EE),
                        highlightedBorderColor: Colors.black.withOpacity(0.12),
                        onPressed: () {
                          // Respond to button press
                          onAnimationComplete();
                        },
                        child: Text("View Orders", style: proceedStyle),
                      ),
                      new FlareActor("assets/flares/success.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          animation: "success")
                    ],
                  )
                ] //Text("Your Order Reference is:", style: TextStyle(inherit: true)),Text(widget.orderRef, textAlign: TextAlign.left )]
                )),
        /*new FlareActor(
            "assets/flares/success.flr",
            alignment: Alignment.center,
            fit: BoxFit.fill,
            animation: "success",
            callback: (s) => onAnimationComplete(s))],
          ),*/
      ),
      //),
    );
  }

  TextStyle proceedStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.12,
      color: Color.fromRGBO(245, 116, 15, 1) //Color.fromRGBO(255, 255, 255, 1),
      //backgroundColor:  Color.fromRGBO(245, 116, 15, 1),
      );

  @override
  void initState() {
    super.initState();
  }

  void onAnimationComplete() {
    print("on animation complete called with ");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => AllOrdersScreen(widget.getFirebaseUser)),
    );
  }
}
