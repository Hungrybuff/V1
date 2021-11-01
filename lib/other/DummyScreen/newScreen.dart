import 'package:flutter/material.dart';
import 'package:hungrybuff/other/DummyScreen/bloc/bloc.dart';

import '../../model/user_model.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  UserBloc userBloc = UserBloc.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return FutureBuilder<List<User>>(
        future: userBloc.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<User> user = snapshot.data;
            return buildUI(user);
          } else
            return Center(
                child: new CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ));
        });
  }

  Widget buildUI(List<User> users) {
    return new ListView.builder(
      itemBuilder: (BuildContext c, int i) {
        return new Text(users[i].toString());
      },
      itemCount: users.length,
    );
  }
}
