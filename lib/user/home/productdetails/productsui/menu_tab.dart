import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/cart_model.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/user/booking_module/booking_bloc.dart';
import 'package:hungrybuff/user/home/home/home_screen_bloc.dart';
import 'package:hungrybuff/utils/utils.dart';

class MenuTab extends StatefulWidget {
  final String foodTruckId;

  MenuTab(this.foodTruckId);

  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  HomeScreenBloc homeScreenBloc = HomeScreenBloc.getInstance();
  BookingBloc bookingBloc = BookingBloc.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('trucks')
            .document(widget.foodTruckId)
            .collection('items')
            .where("isAvailable", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.connectionState != ConnectionState.active) {
            return Center(child: buildDefaultCircularProgressIndicator());
          }
          print(snapshot.data.documents.length);
          return snapshot.data.documents.length == 0
              ? Center(child: Text('No Items for this Food Truck'))
              : CustomScrollView(
                  slivers: <Widget>[
                    buildSliverList(snapshot),
                  ],
                );
        });
  }

  Widget buildSliverList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      FoodCartItem foodItem =
          FoodCartItem.fromJson(snapshot.data.documents[index].data);
      if (foodItem.foodTruckID == null) {
        foodItem.foodTruckID = widget.foodTruckId;
      }
      if (foodItem.itemID == null || foodItem.itemID == "") {
        foodItem.itemID = snapshot.data.documents[index].documentID;
      }
      bookingBloc.updateFoodTruckId(foodItem);
      return getParticularItemListTile(foodItem, widget.foodTruckId,
          snapshot.data.documents[index].documentID);
    },
            childCount: snapshot.data.documents.length,
            addAutomaticKeepAlives: false));
  }

  Widget getParticularItemListTile(
      FoodCartItem model, String foodTruckID, String itemID) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(6.0),
            child: ListTile(
              leading: buildDishPic(model),
              title: Row(
                children: <Widget>[
                  getIsVegIcon(model),
                  buildDishName(model),
                ],
              ),
              subtitle: buildPriceWidget(model),
              trailing: buildAddOrRemoveButton(itemID, model),
            )),
      ),
    );
  }

  Widget buildAddOrRemoveButton(String itemID, FoodCartItem model) {
    return StreamBuilder<Cart>(
        stream: bookingBloc.foodItemsStream,
        builder: (context, snapshot) {
          return AnimatedContainer(
            child: getListTileTrailingButton(snapshot, model),
            duration: Duration(
              seconds: 10,
            ),
          );
        });
  }

  Widget getListTileTrailingButton(
      AsyncSnapshot<Cart> snapshot, FoodCartItem model) {
    if (isSnapshotLoading(snapshot)) {
      return buildDefaultCircularProgressIndicator();
    } else {
      model.quantity = 0;
      FoodCartItem itemFromCart;
      if (snapshotHasData(snapshot)) {
        itemFromCart = isFoodItemAddedInCart(snapshot, model)
            ? snapshot.data.foodItemsInCart[model.itemID]
            : model;
      } else {
        itemFromCart = model;
      }
      return itemFromCart.quantity < 1
          ? buildAddButton(itemFromCart)
          : buildChangeQuantityButton(itemFromCart);
    }
  }

  bool isFoodItemAddedInCart(
          AsyncSnapshot<Cart> snapshot, FoodCartItem model) =>
      snapshot.data.foodItemsInCart.containsKey(model.itemID);

  bool snapshotHasData(AsyncSnapshot<Cart> snapshot) {
    return snapshot.hasData &&
        snapshot.data.foodItemsInCart != null &&
        snapshot.data.foodItemsInCart.length > 0;
  }

  Widget buildDefaultCircularProgressIndicator() {
    return CircularProgressIndicator(
      backgroundColor: Colors.deepOrangeAccent,
    );
  }

  bool isSnapshotLoading(AsyncSnapshot snapshot) {
    return snapshot.connectionState != ConnectionState.active &&
        snapshot.connectionState != ConnectionState.done;
  }

  Widget buildChangeQuantityButton(FoodCartItem itemFromCart) {
    return SizedBox(
      width: 110,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 24.0,
              ),
              onPressed: () => bookingBloc.increaseQuantityByOne(itemFromCart),
            ),
            new Text(
              itemFromCart.quantity.toString(),
              style: itemFromCart.quantity > 9
                  ? TextStyle(fontSize: 12.0)
                  : TextStyle(fontSize: 14.0),
            ),
            new IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
                size: 24.0,
              ),
              onPressed: () => bookingBloc.decreaseQuantityByOne(itemFromCart),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddButton(FoodCartItem itemFromCart) {
    return SizedBox(
      width: 60,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.deepOrange,
        onPressed: () => bookingBloc.increaseQuantityByOne(itemFromCart),
        child: Text(
          'Add',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
