class CartBloc {
  static CartBloc _instance;

//  CartRepo cRepo;

  static CartBloc getInstance() {
    if (_instance == null) _instance = CartBloc();
    return _instance;
  }

//  CartBloc._internal() {
//    cRepo = CartRepo.getInstance();
//  }
//
//  List<CartModel> getList() {
//    return cRepo.getList();
//  }
}
