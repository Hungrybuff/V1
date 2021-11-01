//
//
//import 'package:cloud_functions/cloud_functions.dart';
//import 'package:hungrybuff/Home_Module/events/event_dummy_source.dart';
//
//class Repo {
//  APISource apiSource = APISource.getInstance();
//  DummySource dummy = new DummySource();
//
//  List<Event> getList() {
//    apiSource.getEvents().then((value) {
//      print(value.toString());
//    });
//    return dummy.getList();
//  }
//}
//
//class APISource {
//  static APISource _instance;
//
//  static APISource getInstance() {
//    if (_instance == null) _instance = new APISource();
//    return _instance;
//  }
//
//  /*Future<List<EventModel>>*/
//  getEvents() async {
//    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
//      functionName: 'returnEventsTest',
//    );
//    HttpsCallableResult resp = await callable.call();
//    print(resp.data);
//    Iterable list = json.decode(resp.data.toString());
//    var events = list.map((model) => Event.fromJson(model)).toList();
//    /*return ListOfEventsGenerator.fromJson(jsonDecode(resp.data.toString()))
//        .listOfEvents;*/
//  }
//}
