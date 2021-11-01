import 'package:flutter/material.dart';

class StepTwo extends StatefulWidget {
  @override
  _StepTwoState createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  TextEditingController stallNameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(text: 'Details of ', style: detailStyle),
                TextSpan(text: 'Food Stall,', style: stallStyle),
              ])),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Please enter your stall details',
                  style: greyStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      child: Text('Stall Name', style: hintStyle),
                    ),
                    Container(
                      height: 54.0,
                      padding: EdgeInsets.only(left: 8.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey)),
                      child: TextField(
                        controller: stallNameController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      child: Text('Location', style: hintStyle),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      height: 54.0,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey)),
                      child: TextField(
                        controller: stallNameController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('Go to Maps');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 20.0,
                        width: 120.0,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.deepOrange),
                        child: Text(
                          'Pick from Map >',
                          style: pickStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.center,
                  height: 54.0,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Upload Stall Photo',
                          style: uploadStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.center,
                  height: 54.0,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Upload Profile Photo',
                          style: uploadStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print('Stall Submitted');
            },
            child: Container(
              alignment: Alignment.center,
              height: 54.4,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange])),
              child: Text(
                'SUBMIT',
                style: submitStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle detailStyle = new TextStyle(
      color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.normal);

  TextStyle stallStyle = new TextStyle(
      color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold);

  TextStyle greyStyle = new TextStyle(
      color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.normal);

  TextStyle uploadStyle = new TextStyle(
      color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.normal);

  TextStyle hintStyle = new TextStyle(
      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500);

  TextStyle pickStyle = new TextStyle(
      color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500);

  TextStyle submitStyle = new TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold);
}
