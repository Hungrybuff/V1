import 'package:flutter/material.dart';
import 'package:hungrybuff/owner/Utils/Widgets.dart';

class DataDisplayWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Function(T data) activeWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return loadingWidget;
              break;
            case ConnectionState.waiting:
              return loadingWidget;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return activeWidget(snapshot.data);
              break;
            default:
              return errorWidget;
          }
        });
  }

  DataDisplayWidget(
      {@required this.stream,
      @required this.loadingWidget,
      this.errorWidget = UtilWidgets.errorWidget,
      @required this.activeWidget});
}
