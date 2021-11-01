import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hungrybuff/model/user_model.dart';

class UserRepo {
  static UserRepo instance;

  static UserRepo getInstance() {
    if (instance == null) instance = new UserRepo();
    return instance;
  }

  Future<List<User>> getUserData() async {
    var s = await APISource().fetchAlbum();
    print("Body = " + s.body);
    User userFromAPI = await APISource().getUserData();
    List<User> usersList = new List();
    for (int i = 0; i < 10; i++) usersList.add(userFromAPI);
    return usersList;
  }
}

class APISource {
  Future<User> getUserData() async {
//    User userToReturn = new User();
//
//    var response = await http.get('https://demo6198061.mockable.io/ballebaaz');
//
//    Map<String, dynamic> map = jsonDecode(response.body);
//
//    userToReturn.name = map["name"];
//    userToReturn.age = map["age"];
//    userToReturn.height = map["height"];
//
    var response = await http.get('https://demo6198061.mockable.io/ballebaaz');

    User userToReturn = User.fromJson(jsonDecode(response.body));

    return userToReturn;
  }

  Future<http.Response> fetchAlbum() async {
    return http.get('https://demo6198061.mockable.io/ballebaaz');
  }
}

// class MockDataSource {
//   static Future<List<User>> getUserData() async {
//     await Future.delayed(Duration(seconds: 1));
//     User user = new User(name: "Satya", age: 25, height: 5.8);
//     List<User> list = new List();
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     list.add(user);
//     return list;
//   }
// }
