import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/food_cart_item.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/model/order.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/orders_bloc.dart';
import 'package:hungrybuff/owner/utils/Widgets.dart';

class NewOrdersTab extends StatefulWidget {
  @override
  _NewOrdersTabState createState() => _NewOrdersTabState();
}

class _NewOrdersTabState extends State<NewOrdersTab> {
  OwnerHomeBloc _homeBloc = OwnerHomeBloc.getInstance();

  @override
  void initState() {
    super.initState();
    _homeBloc.init();
  }

  OrdersBloc bloc = OrdersBloc.getInstance();
  ReasonBloc reasonBloc = ReasonBloc.getInstance();
  bool tile1=false,tile2=false,tile3=false,tile4=false;
  String reject_reason;
  TextEditingController othersController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<QuerySnapshot>>(
        future: bloc.getNewOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Center(child: new CircularProgressIndicator());
          return StreamBuilder<QuerySnapshot>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                //print("Snapshot:"+snapshot.toString());
                //print(snapshot.data.toString());
                if (snapshot.connectionState != ConnectionState.done &&
                    snapshot.connectionState != ConnectionState.active) {
                  return Center(child: new CircularProgressIndicator());
                }
                if ( snapshot.data==null || snapshot.data.documents==null || snapshot.data.documents.length == 0 ) {
                  return Center(child: new Text("No new Orders"));
                }
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return newOrderCard(
                        Order.fromJson(snapshot.data.documents[index].data));
                  },
                );
              });
        });
  }

  Widget listTile(){
    return Card(
      child: Column(

      ),
    );
  }

  Widget vegIcon(Order nModel) {
    if (nModel.foodItemsInOrder.values.toList()[0].foodCategory=='veg'||nModel.foodItemsInOrder.values.toList()[0].foodCategory=='vegan') {
      return Icon(Icons.filter_center_focus, color: Colors.green);
    } else
      return Icon(Icons.filter_center_focus, color: Colors.red);
  }

  Widget newOrderCard(Order order) {
    print("Printing order:"+order.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  buildOrderIdWidget(order),
                  buildDivider(),
                  buildFoodItemsList(order),
                  buildBottomWidget(order)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuantity(FoodCartItem model) {
    return new Text("QTY X " + model.quantity.toString());
  }

  Widget buildDishName(FoodItem model) {
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

  Widget buildNameAndImage(FoodItem model) {
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

  Widget getIsVegIcon(FoodItem model) {
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

  Widget buildPriceWidget(FoodItem model) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        '£${model.price}',
        style: TextStyle(
            color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.bold),
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

  Widget buildNonVegItemTile(
      FoodItem model, String foodTruckID, bool lastItem) {
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

  Widget buildFoodItemsList(Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: ListView.builder(
        shrinkWrap: true, // 1st add
        physics: ClampingScrollPhysics(),
        itemBuilder: (c, i) {
          return Column(
            children: [
              buildNonVegItemTile(order.foodItemsInOrder.values.toList()[i],
                  order.foodTruckID, isLastItem(i, order)),
              isLastItem(i, order) ? buildDivider() : new Container()
            ],
          );
        },
        itemCount: order.foodItemsInOrder.values.length,
      ),
    );
  }

  bool isLastItem(int i, Order order) => i == order.foodItemsInOrder.length - 1;

  Divider buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1.0,
      indent: 5.0,
      endIndent: 5.0,
    );
  }

  Widget buildBottomWidget(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UtilWidgets.buildDate(order.time),
              new Text(" || "),
              UtilWidgets.buildTime(order.time),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () async {
                    print('Order Accepted');
                    await bloc.acceptOrder(order);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 25.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.green),
                    child: Text(
                      'Accept',
                      style: buttonStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('Order Rejected');
                  onTapSubmit(order);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 25.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.red),
                  child: Text(
                    'Reject',
                    style: buttonStyle,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildOrderIdWidget(Order nModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '#${nModel.orderId.toString()}',
            style: ordStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.attach_money),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onTapSubmit(Order order) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildReason(setState),
                    Visibility(visible: tile4,child: TextField(controller: othersController,)),
                    RaisedButton(
                      onPressed: () {
                        print("Reason Submitted");
                        bloc.rejectOrder(order,rejectedReason: othersController.text==null?reject_reason:othersController.text);
                        Navigator.pop(context);
                      },
                      color: Colors.deepOrangeAccent,
                      child: Center(
                        child: new Text(
                          'Done',
                          style: doneStyle,
                        ),
                      ),
                    )
                    /*InkWell(
                    onTap: () {
                      print('Reason Submitted');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0),
                        color: Colors.deepOrange,
                      ),
                      child: new Text(
                        'Done',
                        style: doneStyle,
                      ),
                    ),
                  )*/
                  ],
                ),
              );
            },
          );
        });
  }

  Widget _buildReason(void Function(void Function() p1) setState) {
    return Column(
      children: [
        Card(
            elevation: 0.0,
            child: ListTile(
                title: Text(
                  "No Ingredient",
                  style: selectedStyle,
                ),
                trailing: Icon(
                  Icons.check,
                  color: tile1 ? Colors.deepOrange : Colors.white,
                ),
                onTap: () {
                  setState(() {
                    tile1=!tile1;
                    tile2=false;
                    tile3=false;
                    tile4=false;
                    reject_reason="No Ingredient";
                  });
                })),
        Card(
            elevation: 0.0,
            child: ListTile(
                title: Text(
                  "Time to Close",
                  style: selectedStyle,
                ),
                trailing: Icon(
                  Icons.check,
                  color: tile2 ? Colors.deepOrange : Colors.white,
                ),
                onTap: () {
                  setState(() {
                    tile2=!tile2;
                    tile1=false;
                    tile3=false;
                    tile4=false;
                    reject_reason="Time to Close";
                  });
                })),
        Card(
            elevation: 0.0,
            child: ListTile(
                title: Text(
                  "Lot of Pending Orders",
                  style: selectedStyle,
                ),
                trailing: Icon(
                  Icons.check,
                  color: tile3 ? Colors.deepOrange : Colors.white,
                ),
                onTap: () {
                  setState(() {
                    tile3=!tile3;
                    tile1=false;
                    tile2=false;
                    tile4=false;
                    reject_reason="Lots Of Pending Orders";
                  });
                })),
        Card(
            elevation: 0.0,
            child: ListTile(
                title: Text(
                  "Others",
                  style: selectedStyle,
                ),
                trailing: Icon(
                  Icons.check,
                  color: tile4 ? Colors.deepOrange : Colors.white,
                ),
                onTap: () {
                  setState(() {
                    tile4=!tile4;
                    tile1=false;
                    tile2=false;
                    tile3=false;
                  });
                })),
      ],
    );
    /*return Card(
      elevation: 0.0,
      child: ListTile(
          title: Text(
            model[index].reason,
            style: selectedStyle,
          ),
          trailing: Icon(
            Icons.check,
            color: model[index].isTap?Colors.deepOrange:Colors.white,
          ),
          onTap: (){
            setState((){
              model[index].isTap=!model[index].isTap;
              reasonModel=model;
              bloc.rejectController.
              bloc.rejectController.add(reasonModel);
            });
          }
      ),
    );*/
  }

  TextStyle titleStyle = new TextStyle(
      fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500);

  TextStyle greyStyle = new TextStyle(
      fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.w500);

  TextStyle ordStyle = new TextStyle(
      fontSize: 16.0, color: Colors.deepOrange, fontWeight: FontWeight.w500);

  TextStyle priceStyle = new TextStyle(
      fontSize: 16.0, color: Colors.green, fontWeight: FontWeight.w500);

  TextStyle reasonStyle = new TextStyle(
      fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500);

  TextStyle selectedStyle = new TextStyle(
      fontSize: 16.0, color: Colors.deepOrange, fontWeight: FontWeight.w500);

  TextStyle buttonStyle = new TextStyle(
      fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.w500);

  TextStyle doneStyle = new TextStyle(
      fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500);
}

class ReasonModel {
  String reason;
  bool isTap;

  ReasonModel(this.reason, this.isTap);

  @override
  String toString() {
    return 'ReasonModel{reason: $reason, isTap: $isTap}';
  }
}

class ReasonList {
  List<ReasonModel> list = new List();

  ReasonModel reason1 = new ReasonModel('No Ingredient', false);
  ReasonModel reason2 = new ReasonModel('Time to Close', false);
  ReasonModel reason3 = new ReasonModel('Lot of Pending Orders', false);
  ReasonModel reason4 = new ReasonModel('Other', false);

  List<ReasonModel> getList() {
    list.clear();
    list.add(reason1);
    list.add(reason2);
    list.add(reason3);
    list.add(reason4);
    return list;
  }
}

class ReasonRepo {
  static ReasonRepo _instance;

  static ReasonRepo getInstance() {
    if (_instance == null) _instance = new ReasonRepo();
    return _instance;
  }

  ReasonList rList = new ReasonList();

  List<ReasonModel> getList() {
    return rList.getList();
  }
}

class ReasonBloc {
  static ReasonBloc _instance;

  static ReasonBloc getInstance() {
    if (_instance == null) _instance = new ReasonBloc();
    return _instance;
  }

  ReasonRepo repo = new ReasonRepo();

  List<ReasonModel> getList() {
    return repo.getList();
  }
}
