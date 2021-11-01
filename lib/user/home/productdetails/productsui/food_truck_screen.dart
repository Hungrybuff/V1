import 'package:flutter/material.dart';
import 'package:hungrybuff/model/cart_model.dart';
import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/user/Booking_Module/cartScreen/cart_ui/cart_page_coupon_applied.dart';
import 'package:hungrybuff/user/booking_module/booking_bloc.dart';
import 'package:hungrybuff/user/home/home/home_screen_bloc.dart';
import 'package:hungrybuff/user/home/productdetails/productsui/menu_tab.dart';
import 'package:hungrybuff/user/home/productdetails/productsui/tab_2.dart';
import 'package:hungrybuff/user/home/productdetails/productsui/tab_3.dart';
import 'package:hungrybuff/user/home/productdetails/productsui/tab_4.dart';

class FoodTruckDetailsScreen extends StatefulWidget {
  final FoodTruck foodTruck;

  FoodTruckDetailsScreen(this.foodTruck);

  @override
  _FoodTruckDetailsScreenState createState() => _FoodTruckDetailsScreenState();
}

class _FoodTruckDetailsScreenState extends State<FoodTruckDetailsScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  BookingBloc bookingBloc = BookingBloc.getInstance();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  HomeScreenBloc homeBloc = HomeScreenBloc.getInstance();
  UtilColors uCol = new UtilColors();
  bool isFloating = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: gradientButton(),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              buildSliverAppBar(),
              buildSliverPersistentHeader(),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              MenuTab(
                widget.foodTruck.foodTruckId,
              ),
              Center(
                child: Text('No photos xx available'),
              ),
              Center(
                child: Text('No reviews xx available'),
              ),
              Center(
                child: Text('No timings xx available'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader buildSliverPersistentHeader() {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: tabController,
          labelColor: Colors.deepOrangeAccent,
          unselectedLabelColor: Colors.deepOrangeAccent,
          isScrollable: true,
          indicatorColor: Colors.transparent,
          labelStyle: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 24.0,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 18.0,
          ),
          tabs: [
            Tab(text: 'Menu'),
            Tab(text: "Photos"),
            Tab(text: "Reviews"),
            Tab(text: "Opening Hours"),
          ],
        ),
      ),
      pinned: true,
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 300.0,
        floating: false,
        pinned: true,
        backgroundColor: Colors.white,
        actions: <Widget>[buildSharedButton(), buildSavedButton()],
        flexibleSpace: buildFlexibleSpaceBar());
  }

  FlexibleSpaceBar buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.only(bottom: 12.0),
      title: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[buildRating(), buildETA(), buildIsOpenNow()],
        ),
      ),
      background: buildNetworkImage(),
    );
  }

  Container buildIsOpenNow() {
    return Container(
        alignment: Alignment.center,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.green),
        padding: EdgeInsets.only(left: 8.0, right: 6.0),
        child: Text(
          "Open Nowxx",
          style: bookStyle,
          textAlign: TextAlign.center,
        ));
  }

  Widget buildETA() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: Colors.white,
                size: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "xx mins",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.white),
                ),
              )
            ]),
        Text(
          "Estimated Time",
          style: TextStyle(
              fontSize: 12.0, color: Color.fromRGBO(159, 159, 159, 1)),
        )
      ],
    );
  }

  Widget buildRating() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.white,
              size: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "x.0",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        Text(
          "xxx Ratings",
          style: TextStyle(
              fontSize: 12.0, color: Color.fromRGBO(159, 159, 159, 1)),
        )
      ],
    );
  }

  Image buildNetworkImage() {
    return Image.network(
      'https://images.unsplash.com/photo-1570441262582-a2d4b9a916a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
      fit: BoxFit.cover,
    );
  }

  IconButton buildSavedButton() {
    return IconButton(
      icon: Icon(Icons.turned_in),
      color: Colors.white,
      iconSize: 24.0,
      onPressed: () {
        print('Saved');
      },
    );
  }

  IconButton buildSharedButton() {
    return IconButton(
      icon: Icon(Icons.share),
      color: Colors.white,
      iconSize: 24.0,
      onPressed: () {
        print('Shared');
      },
    );
  }

  Widget gradientButton() {
    return StreamBuilder<Cart>(
        stream: bookingBloc.foodItemsStream,
        builder: (context, snapshot) {
          return AnimatedCrossFade(
            crossFadeState: getCrossFadeState(snapshot),
            firstChild: new Text(""),
            duration: Duration(milliseconds: 300),
            secondChild: buildGoToCartButton(snapshot, context),
          );
        });
  }

  Widget buildGoToCartButton(
      AsyncSnapshot<Cart> snapshot, BuildContext context) {
    double totalCost;
    Cart order = snapshot.data;
    if (order != null) totalCost = order.totalCost;

    return InkWell(
      onTap: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FoodCartScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 14.0, right: 14.0),
        child: Hero(
          tag: "buy-button",
          child: Container(
            alignment: Alignment.center,
            height: 56.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient:
                    LinearGradient(colors: [uCol.gradient2, uCol.gradient1])),
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${getNumberOfItems(order)} Items | ${buildTotalCost(totalCost)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "View Cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 24.0,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double buildTotalCost(double totalCost) {
    if (totalCost == null) return 0.0;
    return totalCost;
  }

  int getNumberOfItems(Cart order) {
    if (order == null || order.foodItemsInCart == null) return 0;
    return order.foodItemsInCart.length;
  }

  TextStyle ratStyle =
      new TextStyle(fontSize: 12.0, color: Color.fromRGBO(159, 159, 159, 1));

  TextStyle titleStyle = new TextStyle(
      fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle bookStyle = new TextStyle(
    color: Colors.white,
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle descStyle = new TextStyle(
    color: Color.fromRGBO(58, 58, 58, 1),
    fontSize: 14.0,
    letterSpacing: 0.07,
  );

  List<Widget> _buildBody() {
    List<Widget> list = new List();

    Widget nameRow = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.foodTruck.foodTruckName,
            style: titleStyle,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15.0)),
              height: 20.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Pre-Booking",
                style: bookStyle,
              )),
        ],
      ),
    );

    Widget locationRow = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 20.0,
            ),
            Flexible(
              child: Text(
                "Location of the Food Stall and the latitude and longitude of the shop",
                style: descStyle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
              ),
            )
          ],
        ),
      ]),
    );

    Widget description = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.foodTruck.description,
        style: descStyle,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: true,
      ),
    );

    Widget tabs = productTabs(widget.foodTruck.foodTruckId);

    list.clear();
    list.add(nameRow);
    list.add(locationRow);
    list.add(description);
    list.add(tabs);
    return list;
  }

  Widget productTabs(String foodTruckId) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      child: ListView(
        children: <Widget>[
          Container(
            height: 500.0,
            child: DefaultTabController(
              initialIndex: 0,
              length: 4,
              child: Column(
                children: <Widget>[
                  TabBar(
                    isScrollable: true,
                    unselectedLabelStyle: unSelectStyle,
                    unselectedLabelColor: Color.fromRGBO(159, 159, 159, 1),
                    labelColor: Color.fromRGBO(245, 116, 14, 1),
                    labelStyle: tabStyle,
                    indicatorColor: Color.fromRGBO(245, 116, 14, 1),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Text(
                        "Menu",
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Photos",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Reviews",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Opening Hours",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        MenuTab(foodTruckId),
                        Tab2(),
                        Tab3(),
                        Tab4(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static TextStyle tabStyle = new TextStyle(
      color: Color.fromRGBO(245, 116, 14, 1),
      fontSize: 24.0,
      letterSpacing: 0.1);

  static TextStyle unSelectStyle = new TextStyle(
      color: Color.fromRGBO(159, 159, 159, 1),
      fontSize: 16.0,
      letterSpacing: 0.1);

  TextStyle restStyle = new TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w300,
      color: Color.fromRGBO(58, 58, 58, 1));

  TextStyle activeStyle = new TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(58, 58, 58, 1));

  CrossFadeState getCrossFadeState(AsyncSnapshot<Cart> snapshot) {
    if (snapshot.connectionState != ConnectionState.active &&
        snapshot.connectionState != ConnectionState.done) {
      return CrossFadeState.showFirst;
    } else if (!snapshot.hasData) {
      return CrossFadeState.showFirst;
    } else
      return CrossFadeState.showSecond;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
