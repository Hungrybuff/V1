import 'package:flutter/material.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:intl/intl.dart';

Widget getParticularItemListTile(FoodCartItem model, String foodTruckID) {
  return Column(
    children: [
      ListTile(title: buildNameAndImage(model),
        trailing: buildPriceWidget(model),
        subtitle: buildQuantity(model),
        leading: buildDishPic(model),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: new Divider(
          thickness: 1.0,
        ),
      )
    ],
  );
}
Widget buildNameAndImage(FoodCartItem model) {
  return Row(
    children: <Widget>[
      getIsVegIcon(model),
      buildDishName(model),
    ],
  );
}
Icon getIsVegIcon(FoodCartItem model) {
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

Widget buildPriceWidget(FoodCartItem model) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      '£${model.price}',
      style: TextStyle(
          color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildQuantity(FoodCartItem model) {
  return new Text("QTY X " + model.quantity.toString());
}
Widget buildDishPic(FoodCartItem model) {
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

String getCurrencyInLocalFormat(double price)
{
  return NumberFormat.simpleCurrency().format(price);
}