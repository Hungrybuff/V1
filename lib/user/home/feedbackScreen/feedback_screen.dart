import 'package:flutter/material.dart';
import 'package:hungrybuff/other/utils/colors.dart';

class FeedBackScreen extends StatelessWidget {
  UtilColors uCol = new UtilColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Send us your Feedback!",
              style: feedStyle,
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Do you have a suggestion or found a bug?",
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Container(
                height: 100.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "How was your experience?",
                      style: expStyle,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: _rateRow(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _commentBox(),
            )
          ],
        ),
      ),
      bottomNavigationBar: _gradientSubmit(),
    );
  }

  TextStyle feedStyle = new TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle bugStyle =
      new TextStyle(fontSize: 14.0, color: Color.fromRGBO(159, 159, 159, 1));

  TextStyle expStyle = new TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black);

  TextStyle subStyle = new TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white);

  Widget _commentBox() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 8.0, left: 16.0),
        height: 98,
        child: TextField(
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

  Widget _rateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.brightness_low,
          size: 48.0,
          color: Colors.orangeAccent,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.brightness_2,
            size: 48.0,
            color: Colors.orangeAccent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.brightness_3,
            size: 48.0,
            color: Colors.orangeAccent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.brightness_6,
            size: 48.0,
            color: Colors.orangeAccent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.brightness_high,
            size: 48.0,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }

  Widget _gradientSubmit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print("Feedback Submitted");
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
}
