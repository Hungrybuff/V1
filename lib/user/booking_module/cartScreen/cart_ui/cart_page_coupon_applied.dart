import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungrybuff/model/cart_model.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/other/utils/widgets.dart';
import 'package:hungrybuff/user/booking_module/booking_bloc.dart';
import 'package:hungrybuff/user/booking_module/cartScreen/cart_ui/empty_cart.dart';
import 'package:hungrybuff/user/booking_module/payments/payments_UI/payment_options.dart';
import 'package:hungrybuff/user/home/home/home_screen_bloc.dart';

class FoodCartScreen extends StatefulWidget {
  @override
  _FoodCartScreenState createState() => _FoodCartScreenState();
}

class _FoodCartScreenState extends State<FoodCartScreen> {
  BookingBloc _bookingBloc = BookingBloc.getInstance();
  UtilWidgets uWid = new UtilWidgets();
  UtilColors uCol = new UtilColors();
  HomeScreenBloc homeBloc = HomeScreenBloc.getInstance();

  TextEditingController additionalInfoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Cart>(
        stream: _bookingBloc.foodItemsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.connectionState != ConnectionState.active)
            return Center(child: CircularProgressIndicator());
          Cart order = snapshot.data;
          if (order == null) return new EmptyCart();
          return Scaffold(
            appBar: AppBar(
              title: buildTitle(),
            ),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                listOfOrderedItems(order),
                // Expanded(child: Container()),
                getBody(order),
              ]),
            ),
          );
        });
  }

  Widget buildTitle() {
    return Text(
      "Food cart",
      textAlign: TextAlign.left,
      style: titleStyle,
    );
  }

  Widget getBody(Cart order) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _height = logicalSize.height;

    return Column(
      children: [
        getSuggestionsTextField(),
        Container(
            padding: new EdgeInsets.only(top: (_height / 4)),
            margin: new EdgeInsets.only(bottom: 16.0),
            child: getProceedToBuyButton(context, order))
      ],
    );
  }

  Widget getProceedToBuyButton(BuildContext context, Cart order) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 15.0, left: 15.0),
      child: InkWell(
        onTap: () async {
          var order = await _bookingBloc.proceedToBuy(additionalInfoController.text);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PaymentOptions(order)));
        },
        child: Container(
          height: 56.4,
          padding: const EdgeInsets.all(0.0),
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
                        "£" + order.totalCost.toString(),
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
    );
  }

  Padding getSuggestionsTextField() {
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
            child: TextField(
              controller: additionalInfoController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              minLines: 3,
              style: TextStyle(fontSize: 12.0, color: Colors.black),
              decoration: InputDecoration(
                hintText:
                    "Enter any additional information about your order Eg: No Mayo!",
                border: InputBorder.none,
              ),
            ),
          )),
    );
  }

  Widget listOfOrderedItems(Cart order) {
    return order.foodItemsInCart.length == 0
        ? Text("No items")
        : ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return getCard(
                order.foodItemsInCart.values.toList()[index],
              );
            },
            itemCount: order.foodItemsInCart.length,
          );
  }

  Padding offerTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "£50 off in your Total Amount",
            style: totalStyle,
          ),
        ],
      ),
    );
  }

  Widget getCard(FoodCartItem foodItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: getImageWidget(foodItem),
          title: getTitleListTile(foodItem),
          subtitle: getSubTitleLIstTile(foodItem),
          trailing: getTrailingWidget(foodItem),
        ),
      ),
    );
  }

  Widget getTrailingWidget(FoodCartItem foodItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: 16.0,
          ),
          onPressed: () => _bookingBloc.increaseQuantityByOne(foodItem),
        ),
        new Text(
            foodItem.quantity == null ? '1' : foodItem.quantity.toString()),
        new IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            size: 16.0,
          ),
          onPressed: () => _bookingBloc.decreaseQuantityByOne(foodItem),
        ),
      ],
    );
  }

  Widget getSubTitleLIstTile(FoodCartItem foodItem) {
    return Text(
      "£${foodItem.price * foodItem.quantity}",
      style: priceStyle,
    );
  }

  Widget getTitleListTile(FoodCartItem foodItem) {
    return Row(
      children: <Widget>[
        new Icon(
          Icons.radio_button_checked,
          color:  foodItem.foodCategory=='veg'||foodItem.foodCategory=='vegan' ? Colors.green : Colors.red,
          size: 12.0,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 4.0),
            child: new Text(
              foodItem.dishName,
              overflow: TextOverflow.ellipsis,
              style: itemStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget getImageWidget(FoodCartItem foodItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          foodItem.dishPic,
          fit: BoxFit.cover,
          width: 45,
          height: 45,
        ),
      ),
    );
  }

  Widget couponWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
                      'HUNG 50',
                      style: couponStyle,
                    ),
                    Text(
                      'Get Rs.50 Off',
                      style: offStyle,
                    ),
                  ]),
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
}
