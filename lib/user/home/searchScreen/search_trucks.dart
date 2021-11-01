import 'package:flutter/material.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/model/searchTrucksWithItemsModel.dart';
import 'package:hungrybuff/other/utils/styles.dart';
import 'package:hungrybuff/user/home/productdetails/productsui/food_truck_screen.dart';
import 'package:hungrybuff/user/home/searchScreen/bloc/SearchBloc.dart';

/*
class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  static var tag = 'search-results';

  SearchBloc bloc = SearchBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Search Result floating Button");
          onTapSubmitted();
        },
        backgroundColor: Color.fromRGBO(245, 116, 14, 1),
        child: Icon(
          Icons.sort,
          size: 34.0,
        ),
      ),
      appBar: new AppBar(
        elevation: 0.0,
        title: _searchBar(),
        actions: <Widget>[
          IconButton(
            color: Colors.grey,
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder<List<FoodTruck>>(
                    future: bloc.getBlocList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<FoodTruck> list = snapshot.data;
                        if (list == null) {
                          return new Text("data");
                        }
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _card(list[index]);
                          },
                        );
                      } else
                        return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOpen = true;

  Text ifOpen = new Text(
    'OPEN',
    style: openStatus,
  );

  Text ifClose = new Text(
    'CLOSED',
    style: closeStatus,
  );

  Text ifPreBooking = new Text(
    'Pre-Booking',
    textAlign: TextAlign.center,
    style: booking,
  );

  Icon notFav = Icon(
    Icons.favorite_border,
    size: 16.0,
    color: Colors.red,
  );

  Icon fav = new Icon(
    Icons.favorite,
    size: 16.0,
    color: Colors.red,
  );

  Widget _card(FoodTruck sModel) {
    print("searchmodel" + sModel.toString());
    return new Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 28,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    sModel.images,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                flex: 65,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                sModel.foodTruckName,
                                style: truckTitle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bool isFav = bool.fromEnvironment(
                                        sModel.isMyFavourite);
                                    sModel.isMyFavourite = (!isFav).toString();
                                  });
                                },
                                child: Container(
                                  child:
                                      bool.fromEnvironment(sModel.isMyFavourite)
                                          ? fav
                                          : notFav,
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 15.0,
                                color: Colors.grey,
                              ),
                              Expanded(
                                child: Text(
                                  sModel.location,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.deepOrange,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 9.3,
                                        ),
                                        Text(
                                          sModel.rating.toString(),
                                          style: rating,
                                        ),
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(sModel.deliveryTime),
                              )
                            ]),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Visibility(
                              visible: sModel.preBooking,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromRGBO(13, 163, 20, 1)),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: new Text(
                                      'Pre-Booking',
                                      textAlign: TextAlign.center,
                                      style: booking,
                                    )),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: sModel.isOpen ? ifOpen : ifClose),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search Dishes, Food Trucks',
      ),
    );
  }

  void onTapSubmitted() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.fastfood),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "TYPE OF FOODS",
                          style: typeStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 32.0),
                              child: InkWell(
                                  onTap: () {
                                    print("Type Veg");
                                  },
                                  child: Text('Veg')),
                            ),
                            Icon(
                              Icons.filter_center_focus,
                              color: Colors.green,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 32.0),
                              child: InkWell(
                                  onTap: () {
                                    print("Type Non-Veg");
                                  },
                                  child: Text('Non-Veg')),
                            ),
                            Icon(
                              Icons.filter_center_focus,
                              color: Colors.red,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 32.0),
                              child: InkWell(
                                  focusColor: Colors.deepOrange,
                                  onTap: () {
                                    print("Type Vegan");
                                  },
                                  child: Text('Vegan')),
                            ),
                            Icon(
                              Icons.landscape,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                addDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.attach_money),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              " PRICE",
                              style: typeStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 32.0),
                                  child: InkWell(
                                      onTap: () {
                                        print("Price LTH");
                                      },
                                      child: Text('Low to High')),
                                ),
//                              Icon(
//                                Icons.filter_center_focus,
//                                color: Colors.green,
//                              )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 32.0),
                                    child: InkWell(
                                        onTap: () {
                                          print("Price HTL");
                                        },
                                        child: Text('High to Low')),
                                  ),
//                              Icon(
//                                Icons.filter_center_focus,
//                                color: Colors.red,
//                              )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                addDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        children: <Widget>[
//                      Image.asset('assets/botsheet/types_food.png'),
                          Icon(Icons.flash_on),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "SPICE",
                              style: typeStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 32.0),
                                  child: InkWell(
                                      onTap: () {
                                        print("Spice High");
                                      },
                                      child: Text('High')),
                                ),
//                              Icon(
//                                Icons.filter_center_focus,
//                                color: Colors.green,
//                              )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 32.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        print("Spice Low");
                                      },
                                      child: Text(
                                        'Low',
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      )),
//                              Icon(
//                                Icons.filter_center_focus,
//                                color: Colors.red,
//                              )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget addDivider() {
    return Divider(
      color: Colors.grey,
      endIndent: 8.0,
      indent: 8.0,
      thickness: 1.0,
    );
  }

  TextStyle truckTitle = new TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle rating = new TextStyle(
      fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle booking = new TextStyle(
      fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle openStatus = new TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.bold,
      // color: Color.fromRGBO(206, 16, 28, 1),
      color: Colors.green);

  static TextStyle closeStatus = new TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(206, 16, 28, 1),
  );

  TextStyle typeStyle = new TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
}
*/

class SearchResults extends SearchDelegate<String> {
  SearchBloc bloc = SearchBloc.getInstance();
  List<FoodTruckWithItems> listForSearching;
  bool shouldShowRestaurants = true;

  SearchResults({this.listForSearching});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<TruckWithOnlySingleItem> foodTruckWithOneItem;
    final suggestionList = query.isEmpty
        ? listForSearching
        : listForSearching
            .where((p) =>
                p.foodTruck.foodTruckName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                getItemName(p, query))
            .toList();
    if (query.isNotEmpty) {
      for (int i = 0; i < listForSearching.length ?? 0; i++) {
        for (int j = 0;
            j < listForSearching[i].menuItemsList.length ?? 0;
            j++) {
          if (listForSearching[i]
              .menuItemsList[j]
              .dishName
              .toLowerCase()
              .contains(query.toLowerCase())) {
            foodTruckWithOneItem = new List();
            TruckWithOnlySingleItem truckWithOnlySingleItem =
                new TruckWithOnlySingleItem(
                    listForSearching[i].menuItemsList[j],
                    listForSearching[i].foodTruck);
            foodTruckWithOneItem.add(truckWithOnlySingleItem);
          }
        }
      }
    }
    return buildListView(suggestionList, query, foodTruckWithOneItem);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return new FutureBuilder<List<FoodTruckWithItems>>(
      future: bloc.getBlocList(),
      initialData: new List(),
      builder: (BuildContext context,
          AsyncSnapshot<List<FoodTruckWithItems>> snapshot) {
        listForSearching = snapshot.data;
        List<TruckWithOnlySingleItem> foodTruckWithOneItem;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              child: Center(child: Center(child: CircularProgressIndicator())),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return new Text('Error: getting Food trucks');
            final suggestionList = query.isEmpty
                ? listForSearching
                : snapshot.data
                .where((p) =>
            p.foodTruck.foodTruckName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
                getItemName(p, query))
                .toList();
            if (query.isNotEmpty) {
              for (int i = 0; i < snapshot.data.length ?? 0; i++) {
                for (int j = 0;
                j < snapshot.data[i].menuItemsList.length ?? 0;
                j++) {
                  if (snapshot.data[i].menuItemsList[j].dishName
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                    foodTruckWithOneItem = new List();
                    TruckWithOnlySingleItem truckWithOnlySingleItem =
                    new TruckWithOnlySingleItem(
                        snapshot.data[i].menuItemsList[j],
                        snapshot.data[i].foodTruck);
                    foodTruckWithOneItem.add(truckWithOnlySingleItem);
                  }
                }
              }
            }

            return buildListView(suggestionList, query, foodTruckWithOneItem);
        }
        return null; // unreachable
      },
    );
  }

  Widget buildListView(List<FoodTruckWithItems> suggestionList, String query,
      List<TruckWithOnlySingleItem> foodTruckWithOneItem) {
    return StreamBuilder<bool>(
        stream: bloc.searchResultStream,
        initialData: true,
        builder: (context, snapshot) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        bloc.searchResultController.add(true);
                      },
                      color: snapshot.data ? Colors.black : Colors.grey,
                      child: Text(
                        "Restaurant",
                        style: TextStyle(
                          color: snapshot.data ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        bloc.searchResultController.add(false);
                      },
                      color: !snapshot.data ? Colors.black : Colors.grey,
                      child: Text(
                        "Dishes",
                        style: TextStyle(
                          color: !snapshot.data ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                child: snapshot.data
                    ? suggestionList.length != 0
                    ? buildListViewForRestaurants(suggestionList)
                    : Center(
                  child: Text("No results found"),
                )
                    : foodTruckWithOneItem != null
                    ? buildListViewForDishes(foodTruckWithOneItem)
                    : Center(
                  child: Text("No results found"),
                ),
              )
            ],
          );
        });
  }

  Widget buildListViewForDishes(
      List<TruckWithOnlySingleItem> foodTruckWithOneItem,) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        print("food truck with item length is: " +
            foodTruckWithOneItem.length.toString());
        if (foodTruckWithOneItem.length == 0 ||
            foodTruckWithOneItem.length == null)
          return Center(child: Text("Search results found"));
        return buildContainerForEachDishDisplayWidget(
            foodTruckWithOneItem[index], index, context);
      },
      //shrinkWrap: true,
      itemCount: foodTruckWithOneItem.length,
    );
  }

  Widget buildContainerForEachDishDisplayWidget(
      TruckWithOnlySingleItem foodTruckWithOneItem,
      int index,
      BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    FoodTruckDetailsScreen(foodTruckWithOneItem.truck)));
      },
      child: Card(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dishNameWidget(foodTruckWithOneItem),
                Divider(),
                truckNameWidget(foodTruckWithOneItem),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToFootTruckScreen(FoodTruck truck, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FoodTruckDetailsScreen(truck)));
  }

  bool getItemName(FoodTruckWithItems foodTruckWithItems, String query) {
    List<FoodItem> items = foodTruckWithItems.menuItemsList;
    bool checkCase = false;
    for (int index = 0; index < items.length; index++) {
      if (items[index].dishName.toLowerCase().contains(query.toLowerCase())) {
        checkCase = true;
      }
    }
    return checkCase;
  }

  Widget buildListViewForRestaurants(List<FoodTruckWithItems> suggestionList) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildParticularWidgetForEachWidget(
            suggestionList[index], index, context);
      },
      itemCount: suggestionList.length,
    );
  }

  Widget buildParticularWidgetForEachWidget(FoodTruckWithItems suggestionList,
      int inde, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    FoodTruckDetailsScreen(suggestionList.foodTruck)));
      },
      child: Card(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(suggestionList.foodTruck.foodTruckName,
                        style: UtilStyles.boldBlack),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                        ),
                        Text(suggestionList.foodTruck.rating.toString())
                      ],
                    ),
                  ],
                ),
                Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          suggestionList.foodTruck.images.replaceAll("\"", ""),
                          width: 120.0,
                          height: 100.0,
                          fit: BoxFit.fill,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dishNameWidget(TruckWithOnlySingleItem foodTruckWithOneItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getItemNameAndPrice(foodTruckWithOneItem),
          getItemImageWidget(foodTruckWithOneItem)
        ],
      ),
    );
  }

  Widget getItemNameAndPrice(TruckWithOnlySingleItem foodTruckWithOneItem) {
    FoodItem item = foodTruckWithOneItem.item;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isVegIcon(item),
        Text(item.dishName, style: UtilStyles.boldBlack),
        Text("₹" + item.price.toString()),
      ],
    );
  }

  Widget getItemImageWidget(TruckWithOnlySingleItem foodTruckWithOneItem) {
    FoodItem item = foodTruckWithOneItem.item;
    return Container(
      height: 100.0,
      width: 120.0,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
              image: NetworkImage(item.dishPic == null ? '' : item.dishPic),
              fit: BoxFit.fill)),
    );
  }

  Widget isVegIcon(FoodItem item) {
    return item.isVeg
        ? Icon(
      Icons.center_focus_strong,
      color: Colors.green,
    )
        : Icon(
      Icons.center_focus_strong,
      color: Colors.redAccent,
    );
  }

  Widget truckNameWidget(TruckWithOnlySingleItem foodTruckWithOneItem) {
    FoodTruck foodTruck = foodTruckWithOneItem.truck;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(foodTruck.foodTruckName, style: UtilStyles.boldBlack),
          Row(
            children: [Icon(Icons.star), Text(foodTruck.rating.toString())],
          ),
        ],
      ),
    );
  }
}

class TruckWithOnlySingleItem {
  FoodItem item;
  FoodTruck truck;

  TruckWithOnlySingleItem(this.item, this.truck);

  @override
  String toString() {
    return 'TruckWithOnlySingleItem{item: $item, truck: $truck}';
  }
}
