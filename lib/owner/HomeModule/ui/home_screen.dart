import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/HomeModule/bloc/home_bloc.dart';
import 'package:hungrybuff/owner/HomeModule/ui/my_profile.dart';
import 'package:hungrybuff/owner/HomeModule/ui/orders_screen.dart';
import 'package:hungrybuff/owner/HomeModule/ui/revenue_screen.dart';
import 'package:hungrybuff/owner/HomeModule/ui/menu_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  OwnerHomeScreen();

  @override
  _OwnerHomeScreenState createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  OwnerHomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = OwnerHomeBloc.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildBody()),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget buildBody() {
    return StreamBuilder<int>(
      stream: homeBloc.presentStream,
      initialData: 0,
      builder: (context, snapshot) {
        return Container(
          child: getContent(snapshot.data),
        );
      },
    );
  }

  Widget getBottomNavigationBar() {
    return StreamBuilder<int>(
      stream: homeBloc.getStream(),
      initialData: 0,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          fixedColor: Colors.deepOrange,
          showUnselectedLabels: true,
          currentIndex: snapshot.data,
          onTap: (int index) {
            homeBloc.onEventChange(index);
          },
          items: allItems.map((Items item) {
            return BottomNavigationBarItem(
                title: Text(item.name), icon: Icon(item.icon));
          }).toList(),
        );
      },
    );
  }

  List<Items> allItems = <Items>[
    Items('Orders', 0, Icons.fastfood),
    Items('Revenue', 1, Icons.account_balance_wallet),
    Items('Menu', 2, Icons.menu),
    Items('Profile', 3, Icons.account_box),
  ];

  Widget getContent(int data) {
    if (data == 0) return OrdersScreen();
    if (data == 1) return RevenueScreen();
    if (data == 2)
      return MenuScreen();
    else
      return MyProfile();
  }
}

class Items {
  final String name;
  final int index;
  final IconData icon;

  Items(this.name, this.index, this.icon);
}
