import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:hungrybuff/user/order_tracking/orderDetails/order_details.dart';
import 'package:intl/intl.dart';

class AllOrdersScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  AllOrdersScreen(this.firebaseUser);

  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: new AppBar(
            title: Text("All Orders"),
            bottom: TabBar(
              labelColor: Colors.deepOrangeAccent,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.deepOrangeAccent,
              tabs: [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Completed",
                ),
                Tab(
                  text: "Cancelled",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildPendingTab(),
              buildCompletedTab(),
              buildCancelledTab(),
            ],
          )),
    );
  }

  Widget buildStreamControllerAndList(
      Future<List<Order>> stream, Function(Order snapshot) builder) {
    return FutureBuilder<List<Order>>(
        future: stream,
        builder: (context, snapshot) {
          print("snapshot state is" + snapshot.connectionState.toString());
          if (snapshot.connectionState != ConnectionState.done)
            return Center(child: new CircularProgressIndicator());
          if (snapshot.data.length < 1 || snapshot.data.length == null)
            return Center(
              child: Text("No Orders"),
            );
          return new ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) => builder(snapshot.data[index]),
            itemCount: snapshot.data.length,
          );
        });
  }

  Widget buildCancelledTab() {
    String userId = widget.firebaseUser.uid;
    return buildStreamControllerAndList(getCancelledTabQuery(userId),
        (snapshot) => buildOrderCardWidget(snapshot));
  }

  Widget buildCompletedTab() {
    String userId = widget.firebaseUser.uid;
    return buildStreamControllerAndList(getCompletedTabQuery(userId),
        (snapshot) => buildOrderCardWidget(snapshot));
  }

  Widget buildPendingTab() {
    String userId = widget.firebaseUser.uid;
    return buildStreamControllerAndList(getPendingTabQuery(userId),
        (snapshot) => buildOrderCardWidget(snapshot));
  }

  Widget buildOrderCardWidget(Order order) {
    // Order order = Order.fromJson(snapshot.data);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OrderDetails(order))),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  buildNameAndOrderOD(order),
                  Divider(
                    thickness: 1,
                  ),
                  buildFoodCartItemsList(order),
                  buildDateAndAmount(order),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildDateAndAmount(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              buildDate(order.time),
              new Text(
                " ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              buildTime(order.time),
            ],
          ),
          Row(
            children: <Widget>[
              new Text(
                "Total Amount : ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                '£' + order.amountToPay.ceilToDouble().toStringAsFixed(2),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNameAndOrderOD(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("trucks")
                  .document(order.foodTruckID)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return new CircularProgressIndicator();
                return new Text(
                  snapshot.data["foodTruckName"],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                );
                return new Text("");
              }),
          new Text(
            "#" + order.orderRef,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.deepOrangeAccent),
          ),
        ],
      ),
    );
  }

  Widget buildFoodCartItemsList(Order order) {
    return ListView.builder(
      shrinkWrap: true, // 1st add
      physics: ClampingScrollPhysics(),
      itemBuilder: (c, i) {
        return getParticularItemListTile(
            order.foodItemsInOrder.values.toList()[i], order.foodTruckID);
      },
      itemCount: order.foodItemsInOrder.values.length,
    );
  }

  Widget buildTime(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    final DateFormat formatter = DateFormat('H:mm:ss');
    final String formatted = formatter.format(dateTime);
    return new Text(
      formatted,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Widget buildDate(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    final DateFormat formatter = DateFormat('dd-MM-yy');
    final String formatted = formatter.format(dateTime);
    return new Text(
      formatted,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Widget getParticularItemListTile(FoodCartItem model, String foodTruckID) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            leading: buildDishPic(model),
            subtitle: getItemSubTileWidget(model),
            title: getItemTitleWidget(model),
            trailing: buildPriceWidget(model),
          ),
          new Divider(
            thickness: 1.0,
          )
        ],
      ),
    );
  }

  Widget buildDishName(FoodCartItem model) {
    return Flexible(
      child: Container(
        child: Text(
          model.dishName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget getItemTitleWidget(FoodCartItem model) {
    return Row(
      children: <Widget>[
        getIsVegIcon(model),
        buildDishName(model),
      ],
    );
  }

  Widget getIsVegIcon(FoodCartItem model) {
    return  model.foodCategory=='veg'||model.foodCategory=='vegan'
        ? Icon(
            Icons.center_focus_strong,
            color: Colors.green,
          )
        : Icon(
            Icons.center_focus_strong,
            color: Colors.redAccent,
          );
  }

  Widget buildPriceWidget(FoodCartItem model) {
    return Text(
      '£${model.price}',
      style: TextStyle(
          color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.bold),
    );
  }

  Widget buildDishPic(FoodCartItem model) {
    return Container(
      height: 45.0,
      width: 45.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          model.dishPic == null ? '' : model.dishPic,
          fit: BoxFit.fill,
          frameBuilder: (BuildContext c, Widget w, int i, bool b) {
            if (b) {
              return w;
            }
            return AnimatedOpacity(
              child: w,
              opacity: i == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
    );
  }

  Widget getItemSubTileWidget(FoodCartItem model) {
    return new Text("QTY X " + model.quantity.toString());
  }

  Future<List<Order>> getPendingTabQuery(String userId) async {
    List<Order> listToReturn = new List();
    QuerySnapshot snapshot = await Firestore.instance
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .where("orderState", isLessThan: Constants.pendingOrder)
        .where("orderState", isGreaterThan: Constants.cancelled)
        .orderBy("orderState")
        .orderBy("time", descending: true)
        .getDocuments();
    print("pending Documents length is" + snapshot.documents.length.toString());
    List<DocumentSnapshot> documentSnapShot = snapshot.documents;
    for (int i = 0; i < documentSnapShot.length; i++) {
      listToReturn.add(Order.fromJson(documentSnapShot[i].data));
    }

    return listToReturn;
  }

  Future<List<Order>> getCompletedTabQuery(String userId) async {
    List<Order> listToReturn = new List();
    QuerySnapshot snapshot = await Firestore.instance
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .where("orderState", isEqualTo: Constants.finishedOrder)
        /*.orderBy("orderState")*/
        .orderBy("time", descending: true)
        .getDocuments();
    print(
        "Completed Documents length is" + snapshot.documents.length.toString());
    List<DocumentSnapshot> documentSnapShot = snapshot.documents;
    for (int i = 0; i < documentSnapShot.length; i++) {
      listToReturn.add(Order.fromJson(documentSnapShot[i].data));
    }

    return listToReturn;
  }

  Future<List<Order>> getCancelledTabQuery(String userId) async {
    List<Order> listToReturn = new List();
    QuerySnapshot snapshot = await Firestore.instance
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .where("orderState", isEqualTo: Constants.cancelled)
        /* .orderBy("orderState")*/
        .orderBy("time", descending: true)
        .getDocuments();
    print(
        "Completed Documents length is" + snapshot.documents.length.toString());
    List<DocumentSnapshot> documentSnapShot = snapshot.documents;
    for (int i = 0; i < documentSnapShot.length; i++) {
      listToReturn.add(Order.fromJson(documentSnapShot[i].data));
    }

    return listToReturn;
  }
}
