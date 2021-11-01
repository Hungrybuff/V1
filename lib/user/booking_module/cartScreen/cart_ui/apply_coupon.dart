/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/other/utils/widgets.dart';
import 'package:hungrybuff/user/Booking_Module/payments/payments_UI/payment_options.dart';

import 'cart_coupons.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  UtilWidgets uWid = new UtilWidgets();
  UtilColors uCol = new UtilColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        buildTitle(),
        getBodyBottom(),
      ]),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 20.0, bottom: 5.0),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          "Your asdfasdfasdf",
          textAlign: TextAlign.left,
          style: titleStyle,
        ),
      ),
    );
  }

  Widget getCard(FoodCartItem list) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  list.dishPic,
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                          child: new Icon(
                            Icons.radio_button_checked,
                            color:  list.foodCategory=='veg'||list.foodCategory=='vegan'? Colors.green : Colors.red,
                            size: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                          child: new Text(
                            list.dishName,
                            style: itemStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new Text(
                            "£${list.price.toString()}",
                            style: priceStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: <Widget>[
                              new IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 16.0,
                                ),
                                onPressed: () {},
                              ),
                              new Text(list.quantity.toString()),
                              new IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 16.0,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle titleStyle = new TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(39, 39, 39, 1),
  );

  TextStyle quantityStyle = new TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(39, 39, 39, 1),
  );

  TextStyle itemStyle = new TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.07,
    color: Color.fromRGBO(58, 58, 58, 1),
  );

  TextStyle priceStyle = new TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.07,
    color: Color.fromRGBO(24, 181, 45, 1),
  );

  TextStyle couponStyle = new TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(39, 39, 39, 1),
  );

  TextStyle offStyle = new TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(159, 159, 159, 1),
  );

  TextStyle totalStyle = new TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(245, 116, 15, 1),
  );

  TextStyle proceedStyle = new TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.12,
    color: Color.fromRGBO(255, 255, 255, 1),
  );

  Widget getBodyBottom() {
    return Column(children: <Widget>[
      aditionalInformationTextBox(),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            print('Apply Coupon worked');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CouponsPage()));
          },
          child: Container(
            height: 68.0,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(229, 248, 247, 1)),
              borderRadius: BorderRadius.circular(15.0),
              color: Color.fromRGBO(229, 248, 247, 0.5),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Image.asset(
                    'assets/cart/coupon.png',
                    height: 30.0,
                    width: 30.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'APPLY COUPON',
                          style: couponStyle,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, right: 15.0, left: 15.0),
        child: InkWell(
          onTap: () {
            print('Proceed to buy worked');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentOptions()));
          },
          child: Hero(
            tag: "buy-button",
            child: Container(
              padding: const EdgeInsets.all(0.0),
              height: 56.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  colors: [uCol.gradient2, uCol.gradient1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "PROCEED TO BUY",
                      style: proceedStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "£299",
                          style: proceedStyle,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Padding aditionalInformationTextBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            //  color: Colors.purple,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: 98.0,
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                style: TextStyle(fontSize: 12.0, color: Colors.black12),
                decoration: InputDecoration(
                  hintText:
                      "Enter any additional information about your order Eg: No Mayo!",
                  border: InputBorder.none,
                ),
              ),
            ),
          )),
    );
  }
}
*/
