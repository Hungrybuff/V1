import 'package:hungrybuff/model/event_model.dart';

import 'event_repo.dart';

class EventBloc {
  static EventBloc _instance;
  Repo repo = new Repo();

  static EventBloc getInstance() {
    if (_instance == null) _instance = new EventBloc();
    return _instance;
  }

  Future<List<Event>> getList() {
    return repo.getList();
  }
}
