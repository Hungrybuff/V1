import 'package:flutter/cupertino.dart';
import 'package:hungrybuff/other/utils/constants.dart';
import 'package:intl/intl.dart';

class UtilWidgets {
  static const errorWidget = Text("Error");

  static Widget buildTime(int time, {TextStyle style}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    final DateFormat formatter = DateFormat('H:m');
    final String formatted = formatter.format(dateTime);
    return new Text(
      formatted,
      style: style == null
          ? TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
          : style,
    );
  }

  static Widget buildDate(int time, {TextStyle style}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    final DateFormat formatter = DateFormat(Constants.DateTimeFormat);
    final String formatted = formatter.format(dateTime);
    return new Text(
      formatted,
      style: style == null
          ? TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(128, 128, 128, 100))
          : style,
    );
  }
}
