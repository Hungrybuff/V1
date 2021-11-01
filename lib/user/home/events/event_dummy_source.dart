import 'package:hungrybuff/model/event_model.dart';

class DummySource {
  List<Event> list = new List();
  static String url = "https://images.app.goo.gl/GdHxXN5p8Ekheqn98";
  Event model = new Event(
      name: "Truffle Making -Om Sweets & Snacks",
      date: "Mon 20 Jan 10:30AM-1:30PM",
      location: "Young Women Christian Association");

  List<Event> getList() {
    list.clear();
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);
    list.add(model);

    return list;
  }
}
