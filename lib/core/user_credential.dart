import 'package:wander/data/model/item.dart';
import 'package:wander/data/model/user.dart';

class UserCredential {
  static final UserCredential _instance = UserCredential._internal();
  static final User _user = User();
  static final List<Item> _fav = [];
  UserCredential._internal();

  factory UserCredential() => _instance;

  static UserCredential getInstance() => _instance;

  void login({required String email, required String password}) {
    _user.login(email: email, password: password);
  }

  void create(
      {required String email,
      required String password,
      required String firstName,
      required String secondName,
      required String phone}) {
    _user.create(
        email: email,
        password: password,
        firstName: firstName,
        secondName: secondName,
        phone: phone);
  }

  void addToFav({required Item item}) {
    _fav.add(item);
  }

  void removeFromFav({required String id}) {
    _fav.removeWhere((item) => item.id == id);
  }

  bool isItemAddedBefore({required String id}) =>
      _fav.where((item) => item.id == id).isNotEmpty;

  User get user => _user;
  List<Item> get favorites => _fav;
}
