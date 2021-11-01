import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RevenueScreen extends StatefulWidget {
  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  double revenue = 24621.00;
  int today = 168;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: new Text("No data")),
    );
  }

  Widget buildBody() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Stack(overflow: Overflow.visible, children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('assets/home/bg@3x.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 20.0),
                          child: getMonths(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 20.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              formatMethod(format[0]),
                              formatMethod(format[1]),
                              formatMethod(format[2]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
            Expanded(
                flex: 7,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text('Child container'),
                ))
          ],
        ),
        Align(
          alignment: Alignment(0.0, -0.4),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              height: 150.0,
              width: double.infinity,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.fromBorderSide(
                      BorderSide(color: Colors.grey, width: 0.3))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 24.0, bottom: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '£$revenue',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 24.00,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total Earnings',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'In this Week',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                            Text(
                              '£$today',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16.0),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<String> format = ['Weekly', 'Monthly', 'Yearly'];

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  getMonths() {
    return Container(
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: months.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {
                print('The Selected Month is: ${months[index]}');
                Fluttertoast.showToast(
                    msg: 'The Selected Month is: ${months[index]}');
              },
              child: Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white),
                height: 30.0,
                width: 60.0,
                child: Text(
                  '${months[index]}',
                  style: graphStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static formatMethod(String name) {
    return Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.white),
      height: 25.0,
      width: 60.0,
      child: Text(
        name,
        style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  TextStyle graphStyle = new TextStyle(
      color: Colors.deepOrange, fontSize: 14.0, fontWeight: FontWeight.bold);
}
