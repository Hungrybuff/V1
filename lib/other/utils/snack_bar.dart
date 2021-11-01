import 'package:flutter/material.dart';

class SnackBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String snackContent = '';
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Builder(
            builder: (context) => FlatButton(
              color: Colors.deepOrange,
              child: Text('Show snackbar'),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(snackContent),
                  elevation: 10.0,
                  duration: Duration(milliseconds: 5000),
                  action: SnackBarAction(
                      label: 'Okay!',
                      onPressed: () {
                        print('Snackbar pressed');
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                      }),
                ));
              },
            ),
          ),
        ));
  }
}
