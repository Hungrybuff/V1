import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/model/user_details.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:hungrybuff/owner/Utils/Widgets.dart';
import 'package:hungrybuff/user/booking_module/booking_bloc.dart';
import 'package:hungrybuff/user/home/home/home_screen.dart';
import 'package:hungrybuff/user/order_tracking/orderDetails/orderDetailsBloc.dart';
import 'package:hungrybuff/utils/packages/dotted_line.dart';
import 'package:hungrybuff/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class OrderDetails extends StatelessWidget {
  final BookingBloc bookingBloc = BookingBloc.getInstance();
  final OrderDetailsBloc orderDetailsBloc = OrderDetailsBloc.getInstance();
  final Order order;

  OrderDetails(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("#" + order.orderId),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOrderLocations(order),
            buildOrderDetails(),
            getOrderProcessHeading(),
            buildOrderProcess(order),
            getTotalCostHeading(),
            buildTotalCostWidget(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("PAYABLE AMOUNT"),
                  Text(order.amountToPay.toString())
                ],
              ),
            ),
            getCancelButton(order, context)
          ],
        ),
      ),
    );
  }

  Widget buildTotalCostWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: getTotalCostWidget(order),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  Widget getTotalCostHeading() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "TOTAL COST",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget getOrderProcessHeading() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "ORDER PROCESS",
        style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget buildOrderDetails() {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                buildNameAndOrderOD(),
                Divider(
                  thickness: 1,
                ),
                buildFoodCartItemsList(order),
                buildDateAndAmount(order),
              ],
            ),
          )),
    );
  }

  Widget buildNameAndOrderOD() {
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
            "#" + order.orderId,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.deepOrangeAccent),
          ),
        ],
      ),
    );
  }

  Text buildTime(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    final DateFormat formatter = DateFormat('H:m');
    final String formatted = formatter.format(dateTime);
    return new Text(
      formatted,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Text buildDate(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    final DateFormat formatter = DateFormat('dd-MM-yy');
    final String formatted = formatter.format(dateTime);
    return new Text(
      formatted,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                "Total Amount: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              new Text(
                order.amountToPay.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOrderLocations(Order order) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildFoodTruckLocationTab(),
          buildUserLocationTab(),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  Widget buildFoodTruckLocationTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Icon(
              Icons.location_on,
              color: Colors.grey,
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: orderDetailsBloc.getTruckDetails(order),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return new CircularProgressIndicator();
                FoodTruck foodTruck = FoodTruck.fromJson(snapshot.data.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        foodTruck.foodTruckName,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        foodTruck.location,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget buildUserLocationTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Icon(
              Icons.home,
              color: Colors.grey,
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: orderDetailsBloc.getUsersDetails(order),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return new CircularProgressIndicator();
                UserDetails user = UserDetails.fromJson(snapshot.data.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          user.firstName,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Text("Order on ",
                                style: TextStyle(color: Colors.grey)),
                            UtilWidgets.buildDate(order.time,
                                style: TextStyle(color: Colors.grey)),
                            Text(" || ", style: TextStyle(color: Colors.grey)),
                            UtilWidgets.buildTime(order.time,
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget buildOrderProcess(Order order) {
    return Card(
      child: getOrderProcess(order),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  Widget getOrderProcess(Order order) {
    return StreamBuilder<QuerySnapshot>(
        stream: orderDetailsBloc.getStreamForOrderProcess(order),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new CircularProgressIndicator();
          Order trackingOrder = Order.fromJson(snapshot.data.documents[0].data);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getTrackingStepWidget(false, true, "Ordered accept as a COD", "",
                  order, Constants.accepted, trackingOrder.orderState),
              getTrackingStepWidget(
                  false,
                  false,
                  "Cooking Start",
                  "Cooking Started",
                  order,
                  Constants.accepted,
                  trackingOrder.orderState),
              getTrackingStepWidget(
                  false,
                  false,
                  "Ready to Collect ",
                  "Food has been cooked proper now you can pick",
                  order,
                  Constants.readyToBePicked,
                  trackingOrder.orderState),
              getTrackingStepWidget(
                  true,
                  false,
                  "Done",
                  "Please rate if you think food is good",
                  order,
                  Constants.finishedOrder,
                  trackingOrder.orderState),
            ],
          );
        });
  }

  Widget getTrackingStepWidget(bool isLast, bool isStarting, String title,
      String subtitle, Order order, int orderState, int data) {
    print("order state is" + order.orderState.toString());
    return Container(
      height: 90,
      child: Stack(
        overflow: Overflow.clip,
        children: [
          Positioned(
            top: 1,
            left: 20,
            child: Icon(
              Icons.check_circle,
              color: data >= orderState ? Colors.green : Colors.grey,
            ),
          ),
          Positioned(
              left: 20.0 + 11,
              top: isStarting ? 16 : 0,
              bottom: isLast ? 80 : 0,
              width: 3,
              child: HungryBuffDottedLine(
                direction: Axis.vertical,
                dashColor: data >= orderState ? Colors.green : Colors.grey,
                dashGapRadius: 2,
              )),
          Positioned(
            top: 2,
            left: 20.0 + 32,
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
          ),
          Positioned(
            top: 10.0 + 20,
            left: 20.0 + 32,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
              child: Text(subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          ),
          Positioned(
            top: 9,
            right: 1,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                color: data >= orderState ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 14,
                    ),
                    Text(" Done",
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTotalCostWidget(Order order) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Payment Mode"), Text("COD")],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Less Discount"),
              Text(
                order.discountAmount.toString(),
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Total Amount"), Text(order.totalCost.toString())],
          ),
        ),
      ],
    );
  }

  Widget getCancelButton(Order order, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: RaisedButton(
              color: order.orderState < Constants.accepted &&
                      order.orderState != Constants.cancelled
                  ? Colors.redAccent
                  : Colors.grey.shade700,
              onPressed: () async => order.orderState < Constants.accepted &&
                      order.orderState != Constants.cancelled
                  ? await onCancelPressed(order, context)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text('CANCEL',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onCancelPressed(Order order, BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    await bookingBloc.cancelOrder(order);
    await dialog.hide();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
