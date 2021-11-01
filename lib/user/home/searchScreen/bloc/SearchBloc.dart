import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungrybuff/model/food_item.dart';
import 'package:hungrybuff/model/food_truck.dart';
import 'package:hungrybuff/model/searchTrucksWithItemsModel.dart';
import 'package:hungrybuff/user/home/searchScreen/repo/SearchRepository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  static SearchBloc _instance;
  SearchRepository sRepo;

  // SearchRepository repo = SearchRepository.getInstance();

  static SearchBloc getInstance() {
    if (_instance == null) _instance = new SearchBloc._internal();
    return _instance;
  }

  SearchBloc._internal() {
    sRepo = SearchRepository.getInstance();
  }

  BehaviorSubject<bool> searchResultController = new BehaviorSubject<bool>();

  Stream<bool> get searchResultStream => searchResultController.stream;

  Future<List<FoodTruckWithItems>> getBlocList() async {
    List<FoodTruck> foodTruckList = new List();

    List<FoodTruckWithItems> listToReturn = new List();
    QuerySnapshot totalTrucks = await Firestore.instance
        .collection('trucks')
        .where("isOpen", isEqualTo: true)
        .getDocuments();
    List<DocumentSnapshot> documentSnapShot = totalTrucks.documents;
    for (int i = 0; i < documentSnapShot.length; i++) {
      foodTruckList.add(FoodTruck.fromJson(documentSnapShot[i].data));
    }
    for (int i = 0; i < foodTruckList.length; i++) {
      List<FoodItem> itemsListInFoodTruck = new List();
      QuerySnapshot itemsInTruck = await Firestore.instance
          .collection('trucks')
          .document(foodTruckList[i].foodTruckId)
          .collection('items')
          .where("isAvailable", isEqualTo: true)
          .getDocuments();
      List<DocumentSnapshot> itemsDocumentSnapShot = itemsInTruck.documents;
      for (int i = 0; i < itemsDocumentSnapShot.length; i++) {
        itemsListInFoodTruck
            .add(FoodItem.fromJson(itemsDocumentSnapShot[i].data));
      }
      FoodTruckWithItems foodTruckWithItems = new FoodTruckWithItems(
          foodTruck: foodTruckList[i], menuItemsList: itemsListInFoodTruck);
      listToReturn.add(foodTruckWithItems);
    }
    print("list to return in Search Bloc ${listToReturn.length} ");
    return listToReturn;

    //todo jashu changed This
    /*print("Getting list from repo");
    return sRepo.repoSearchTrucks();*/
  }

// SearchQuery getSearchResults() {
//   return repo.getSearchResults();
//
}
