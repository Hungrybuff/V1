import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/HomeModule/ui/delivered_orders_tab.dart';
import 'package:hungrybuff/owner/HomeModule/ui/rejected_order_tab.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Orders"),bottom: TabBar(tabs: [
          Tab(text:"Completed Orders",),
          Tab(text: "Rejected Orders",)
        ],
        ),),
        body: TabBarView(children: [
          DeliveredOrdersTab(),
          RejectedOrdersTab(),
        ],),
      ),
    );
  }
}
