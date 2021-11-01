import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungrybuff/model/event_model.dart';

import 'EventCardWidget.dart';
import 'event_bloc.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String dropDownValue = 'Upcoming';
  static String tag = 'event-page';
  EventBloc bloc = EventBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return getEventsList();
  }

  Widget getRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                'Upcoming &\nRunning Events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: getDropDownButtonWidget(),
          ),
        ],
      ),
    );
  }

  Widget getDropDownButtonWidget() {
    return DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 8,
        underline: Container(
          height: 3,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropDownValue = newValue;
          });
        },
        items: <String>[
          'Upcoming',
          'Pending',
          'Cancelled',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }

  Widget getEventsList() {
    return FutureBuilder<List<Event>>(
        future: bloc.getList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Event> eventsList = snapshot.data;
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getRowWidget(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: eventsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return eventCardWidget(eventsList[index], index, context);
                    },
                  ),
                ),
              ],
            );
          }
          return Center(child: new CircularProgressIndicator());
        });
  }
}
