import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/coupons_model.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/user/Booking_Module/cartScreen/cart_bloc/coupons_bloc.dart';

class CouponsPage extends StatefulWidget {
  @override
  _CouponsPageState createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  CouponsBloc couBloc = CouponsBloc.getInstance();
  TextEditingController caseController = new TextEditingController();
  UtilColors uCol = new UtilColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 40.0),
            child: Text(
              'Apply Coupon',
              textAlign: TextAlign.left,
              style: applyStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 54,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: TextField(
                controller: caseController,
                decoration: InputDecoration(
                    hintText: 'Enter Coupon Code',
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (caseController.text != value.toUpperCase()) {
                    caseController.value = caseController.value
                        .copyWith(text: value.toUpperCase());
                  }
                },
                textAlign: TextAlign.left,
              ),
            ),
          ),
//          ListView(
//            shrinkWrap: true,
//     children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "AVAILABLE COUPONS",
              style: availableStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 05.0, right: 05.0),
            child: dummyCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 05.0, right: 05.0),
            child: dummyCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 05.0, right: 05.0),
            child: dummyCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 05.0, right: 05.0),
            child: dummyCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 05.0, right: 05.0),
            child: dummyCard(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(child: gradientButton()),
    );
  }

  TextStyle applyStyle = new TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(39, 39, 39, 1));

  TextStyle availableStyle = new TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(39, 39, 39, 1));

  TextStyle getStyle = new TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(159, 159, 159, 1));

  TextStyle insideStyle = new TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(255, 255, 255, 1));

  TextStyle applyCoupStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.12,
      color: Color.fromRGBO(255, 255, 255, 1));

  Widget getCard(Coupon list) {
    return Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  list.get,
                ),
                Text(list.code),
              ],
            ),
            Text(list.bottomDesc),
          ]),
    );
  }

  Widget dummyCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        padding: EdgeInsets.all(0.0),
        color: Color.fromRGBO(116, 193, 189, 1),
        dashPattern: [2, 2],
        strokeWidth: 1.0,
        borderType: BorderType.RRect,
        radius: Radius.circular(12.0),
        strokeCap: StrokeCap.round,
        child: new Container(
          height: 90.0,
          child: new Card(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12.0)),
              color: Color.fromRGBO(229, 248, 247, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Get Rs.50 Off"),
                        // new Text(list.get),
                        new Container(
                          height: 40,
                          width: 96,
                          alignment: Alignment.center,
                          child: new Card(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(7.0)),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:
                                    //Text(list.code, style: insideStyle,)
                                    Text(
                                  "HUNG50",
                                  style: insideStyle,
                                )),
                            color: new Color.fromRGBO(119, 136, 153, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                            "Get Rs.50 off on purchase of 250 and above",
                            textAlign: TextAlign.left,
                            style: getStyle,
                          ),
                        ),
                      ])
                ],
              )),
        ),
      ),
    );
  }

  Widget gradientButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          print("gradient working");
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) => FoodCartScreen(wi)));
        },
        child: Container(
          height: 56.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient:
                  LinearGradient(colors: [uCol.gradient2, uCol.gradient1])),
          child: Center(
              child: Text(
            "APPLY COUPON",
            style: applyCoupStyle,
          )),
        ),
      ),
    );
  }
}
