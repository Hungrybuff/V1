import 'package:cloud_functions/cloud_functions.dart';
import 'package:hungrybuff/model/food_truck.dart';

class SearchRepository {
  static SearchRepository _instance;

  static SearchRepository getInstance() {
    if (_instance == null) _instance = new SearchRepository._internal();
    return _instance;
  }

  //Calling the method from api
  Future<List<FoodTruck>> repoSearchTrucks() async {
    print("Search results from repo");
    return APISource.searchResults("");
  }

  SearchRepository._internal();

  DummyTrucks dumTruck = new DummyTrucks();

  List<FoodTruck> getRepoList() {
    return dumTruck.getSourceList();
  }
}

class APISource {
  static Future<List<FoodTruck>> searchResults(String query) async {
    print("Search results from API Source");
    Map<String, String> map = new Map();
    map["search"] = query;
    HttpsCallableResult apiResult = await CloudFunctions.instance
        .getHttpsCallable(functionName: 'getFoodTruckList')
        .call(map);
//    print('Result from api call' + apiResult.data.toString());
    print("Results arrived");
    List<FoodTruck> results = FoodTruckDecoder.fromJson(apiResult.data).results;
    print("Results = " + results.toString());
    return results;
  }
}
