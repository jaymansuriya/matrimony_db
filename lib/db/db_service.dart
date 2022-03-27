import 'package:matrimony_db/db/db_helper.dart';
import 'package:matrimony_db/models/user_model.dart';

class DbService {
  Future<List<UserModel>> getSearch(String a) async {
    await DBHelper.init();

    List<Map<String, dynamic>> user = await DBHelper.query(a);

    return user.map((item) => UserModel.fromMap(item)).toList();
  }

  Future<List<UserModel>> getUser() async {
    await DBHelper.init();

    List<Map<String, dynamic>> user = await DBHelper.details(userTable);

    return user.map((item) => UserModel.fromMap(item)).toList();
  }

  Future<List<UserModel>> getfav() async {
    await DBHelper.init();

    List<Map<String, dynamic>> user = await DBHelper.getfav();

    return user.map((item) => UserModel.fromMap(item)).toList();
  }

  Future<bool> setFav(int n, int id) async {
    await DBHelper.init();

    int ret = await DBHelper.setfav(n, id);
    return ret > 0 ? true : false;
  }

  Future<bool> addUser(UserModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.insert(userTable, model);
    return ret > 0 ? true : false;
  }

  Future<bool> updateUser(UserModel model) async {
    await DBHelper.init();

    bool isSaved = false;
    int ret = await DBHelper.update(userTable, model);
    return ret > 0 ? true : false;
  }

  Future<bool> deleteUser(UserModel model) async {
    await DBHelper.init();

    bool isSaved = false;
    int ret = await DBHelper.delete(userTable, model);
    return ret > 0 ? true : false;
  }
}
