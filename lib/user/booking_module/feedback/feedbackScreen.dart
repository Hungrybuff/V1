import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hungrybuff/model/feedbackModel.dart';
import 'package:hungrybuff/other/utils/colors.dart';
import 'package:hungrybuff/owner/models/food_truck.dart';
import 'package:hungrybuff/user/booking_module/booking_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FeedBackScreenForFoodTruck extends StatefulWidget {
  final FoodTruck foodTruck;

  FeedBackScreenForFoodTruck(this.foodTruck);

  @override
  _FeedBackScreenForFoodTruckState createState() =>
      _FeedBackScreenForFoodTruckState();
}

class _FeedBackScreenForFoodTruckState
    extends State<FeedBackScreenForFoodTruck> {
  BookingBloc bookingBloc = BookingBloc.getInstance();
  double _rating = 3.0;
  UtilColors uCol = new UtilColors();
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(),
                buildRatingBar(),
                getThoughtsText(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: getTextFormField(),
                ),
              ],
            ),
          ),
          getRaisedButton()
        ],
      ),
    );
  }

  Widget buildRatingBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingBar(
        initialRating: 3,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
              );
            case 1:
              return Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
              );
            case 2:
              return Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
              );
            case 3:
              return Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
              );
            case 4:
              return Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
                semanticLabel: "very good",
              );
            default:
              return Container();
          }
        },
        onRatingUpdate: (rating) {
          setState(() {
            _rating = rating;
          });
        },
      ),
    );
  }

  TextStyle subStyle = new TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle bugStyle =
      new TextStyle(fontSize: 14.0, color: Color.fromRGBO(159, 159, 159, 1));
  TextStyle feedStyle = new TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle expStyle = new TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black);

  Widget getRaisedButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onSubmitButtonPressed();
        },
        child: Container(
          alignment: Alignment.center,
          height: 56.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient:
                  LinearGradient(colors: [uCol.gradient2, uCol.gradient1])),
          child: Text(
            "SUBMIT",
            style: subStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> onSubmitButtonPressed() async {
    print("Feedback Submitted" + _rating.toString());
    FeedBackModel feedBackModel = FeedBackModel(controller.text ?? "", _rating);
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    await bookingBloc.sendFeedBack(widget.foodTruck, feedBackModel);
    await dialog.hide();
    Navigator.pop(context);
  }

  Widget getTextFormField() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 8.0, left: 16.0),
        height: 98,
        child: TextField(
            controller: controller,
            maxLines: 3,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              hintText: "Describe your experience here....",
              hintStyle: bugStyle,
            )),
      ),
    );
  }

  Widget getThoughtsText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Do you have a suggestion or any issue?",
            style: bugStyle,
            textAlign: TextAlign.left,
          ),
          Text(
            "Let us know in the field below",
            style: bugStyle,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget getText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "How was your experience?",
        style: expStyle,
        textAlign: TextAlign.left,
      ),
    );
  }
}
