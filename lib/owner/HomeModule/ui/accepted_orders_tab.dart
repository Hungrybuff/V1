import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/orders_bloc.dart';
import 'package:hungrybuff/owner/Utils/Widgets.dart';
import 'package:hungrybuff/utils/utils.dart';

class AcceptedOrdersTab extends StatefulWidget {
  @override
  _AcceptedOrdersTabState createState() => _AcceptedOrdersTabState();
}

class _AcceptedOrdersTabState extends State<AcceptedOrdersTab> {
  OrdersBloc bloc = OrdersBloc.getInstance();
  OwnerHomeBloc _homeBloc = OwnerHomeBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<QuerySnapshot>>(
        future: bloc.getAcceptedOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Center(child: new CircularProgressIndicator());
          return StreamBuilder<QuerySnapshot>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done &&
                    snapshot.connectionState != ConnectionState.active)
                  return Center(child: new CircularProgressIndicator());
                if (snapshot.data.documents.length == 0) {
                  return Center(child: new Text("No new Orders"));
                }
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCard(
                        Order.fromJson(snapshot.data.documents[index].data));
                  },
                );
              });
        });
  }

  Widget vegIcon(Order order) {
    if (order.foodItemsInOrder.values.toList()[0].foodCategory=='veg'||order.foodItemsInOrder.values.toList()[0].foodCategory=='vegan') {
      return Icon(Icons.filter_center_focus, color: Colors.green);
    } else
      return Icon(Icons.filter_center_focus, color: Colors.red);
  }

  Widget _buildCard(Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        decoration:
            new BoxDecoration(borderRadius: new BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  buildOrderIdAndIsVeg(order),
                  getDivider(),
                  buildOrderItemsList(order),
                  getDivider(),
                  buildDateAndStatus(order)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider getDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1.0,
      indent: 5.0,
      endIndent: 5.0,
    );
  }

  Widget buildDateAndStatus(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UtilWidgets.buildDate(order.time),

            ],
          ),
          InkWell(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Finished cooking?'),
                    content: Text('Confirm to notify the user'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                        onPressed: () async {
                          await bloc.markOrderAsReadyToBePicked(order);
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Cooking',
                  style: priceStyle,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.green,
                  size: 20.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildOrderItemsList(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true, // 1st add
        physics: ClampingScrollPhysics(),
        itemBuilder: (c, i) {
          return buildNonVegItemTile(
              order.foodItemsInOrder.values.toList()[i], order.foodTruckID);
        },
        itemCount: order.foodItemsInOrder.values.length,
      ),
    );
  }

  Widget buildNonVegItemTile(FoodCartItem model, String foodTruckID) {
    return ListTile(
      trailing: buildPriceWidget(model),
      title: Row(
        children: [
          getIsVegIcon(model),
          Flexible(
            child: Container(
              child: Text(
                model.dishName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                image: NetworkImage(model.dishPic == null ? '' : model.dishPic),
                fit: BoxFit.fill)),
      ),
    );
  }

  Widget buildDishPic(FoodItem model) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
              image: NetworkImage(model.dishPic == null ? '' : model.dishPic),
              fit: BoxFit.fill)),
    );
  }

  Icon getIsVegIcon(FoodItem model) {
    return model.foodCategory=='veg'||model.foodCategory=='vegan'
        ? Icon(
            Icons.center_focus_strong,
            color: Colors.green,
          )
        : Icon(
            Icons.center_focus_strong,
            color: Colors.redAccent,
          );
  }

  Padding buildDishName(FoodItem model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        model.dishName,
        style: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildNameAndImage(FoodCartItem model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildDishPic(model),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  getIsVegIcon(model),
                  buildDishName(model),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: buildQuantity(model),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildQuantity(FoodCartItem model) {
    return new Text("QTY X " + model.quantity.toString());
  }

  Widget buildPriceWidget(FoodItem model) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        getCurrencyInLocalFormat(model.price),
        style: TextStyle(
            color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildOrderIdAndIsVeg(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '#${order.orderId.toString()}',
                style: ordStyle,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: <Widget>[]

            ),
          ),
        ],
      ),
    );
  }

  TextStyle titleStyle = new TextStyle(
      fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500);

  TextStyle greyStyle = new TextStyle(
      fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.w500);

  TextStyle ordStyle = new TextStyle(
      fontSize: 16.0, color: Colors.deepOrange, fontWeight: FontWeight.w500);

  TextStyle priceStyle = new TextStyle(
      fontSize: 16.0, color: Colors.green, fontWeight: FontWeight.w500);
}
