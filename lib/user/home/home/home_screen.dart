import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/user/booking_module/cartScreen/cart_ui/cart_page_coupon_applied.dart';
import 'package:hungrybuff/user/home/favourites/favourites_blank.dart';
import 'package:hungrybuff/user/home/home/home_screen_bloc.dart';
import 'package:hungrybuff/user/home/myProfile/my_profile.dart';
import 'package:hungrybuff/user/order_tracking/allordersScreen/all_orders.dart';

import 'home_ui/explore_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc bloc = HomeScreenBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getBottomAppBar(),
    );
  }

  Widget getBody() {
    return StreamBuilder<int>(
        stream: bloc.presentIndexStream,
        initialData: 0,
        builder: (context, snapshot) {
          return Container(
            child: getChildInContainer(snapshot.data),
          );
        });
  }

  Widget getBottomAppBar() {
    return StreamBuilder<int>(
        stream: bloc.getStream(),
        initialData: 0,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            unselectedItemColor: Colors.black26,
            backgroundColor: Colors.black26,
            selectedItemColor: Colors.deepOrangeAccent,
            showUnselectedLabels: true,
            currentIndex: snapshot.data,
            onTap: (int index) {
              bloc.onStepChange(index);
            },
            items: allDestinations.map((Destination destination) {
              return BottomNavigationBarItem(
                title: Text(
                  destination.name,
                ),
                icon: Icon(
                  destination.icon,
                ),
              );
            }).toList(),
          );
        });
  }

  Widget getChildInContainer(int data) {
    if (data == 0) return ExplorePage();
//    if (data == 1) return EventDetailsScreen();
    if (data == 1) return FavouritesBlank();
//    if (data == 1) return OrderCreated();
    if (data == 2)
      return AllOrdersScreen(bloc.getCurrentUser);
    else
      return MyProfileScreen(bloc.getCurrentUser);
  }
}

class Destination {
  final String name;
  final int index;
  final IconData icon;

  const Destination(
    this.name,
    this.index,
    this.icon,
  );
}

const List<Destination> allDestinations = <Destination>[
  Destination("Explore", 0, Icons.explore),
//  Destination("Events", 1, Icons.event),
  Destination("Favourite", 2, Icons.bookmark),
  Destination("My Order", 3, Icons.shopping_cart),
  Destination("Profile", 4, Icons.account_box),
];
