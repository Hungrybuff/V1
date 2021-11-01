import 'package:hungrybuff/model/user_model.dart';
import 'package:hungrybuff/other/DummyScreen/repo/repo.dart';

class UserBloc {
  static UserBloc instance;

  UserRepo repo;

  static UserBloc getInstance() {
    if (instance == null) instance = new UserBloc();
    return instance;
  }

  UserBloc() {
    repo = UserRepo.getInstance();
  }

  Future<List<User>> getUserData() {
    return repo.getUserData();
  }
}
