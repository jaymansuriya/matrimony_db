import 'package:matrimony_db/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

abstract class DBHelper {
  static Database? database;
  static int get _version => 1;

  static Future init() async {
    if (database != null) {
      return;
    }

    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'Matrimony.db');
      database = await openDatabase(_path,
          version: _version, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (ex) {
      print(ex);
    }
  }

  static Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final textTypeN = 'TEXT';

    await db.execute(
      "CREATE TABLE Tbl_user (${UserFields.id} $idType,${UserFields.UserName} $textType,${UserFields.DOB} $textType,${UserFields.Age} $intType,${UserFields.Gender} $intType,${UserFields.MobileNumber} $textTypeN,${UserFields.Email} $textTypeN,${UserFields.IsFavorite} $intType,${UserFields.CountryName} $textType,${UserFields.StateName} $textType,${UserFields.CityName} $textType);",
    );
  }

  static Future _onUpgrade(Database db, int oldVersion, int version) async {
    if (oldVersion > version) {
      //
    }
  }

  static Future<List<Map<String, dynamic>>> query(String a) async {
    String search = '\'%' + a + '%\'';
    return database!
        .rawQuery('SELECT * FROM Tbl_user where UserName LIKE $search');
  }

  static Future<List<Map<String, dynamic>>> getfav() async {
    return database!.rawQuery("SELECT * from Tbl_user where IsFavorite = 1");
  }

  static Future<int> setfav(int n, int id) async {
    return await database!
        .rawUpdate("UPDATE Tbl_user SET IsFavorite = $n WHERE id= $id");
  }

  static Future<int> insert(String userTable, Model model) async {
    return await database!.insert(userTable, model.toJson());
  }

  static Future<int> update(String userTable, Model model) async {
    return await database!.update(userTable, model.toJson(),
        where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> delete(String userTable, Model model) async {
    return await database!
        .delete(userTable, where: 'id=?', whereArgs: [model.id]);
  }

  static Future<List<Map<String, dynamic>>> details(String userTable) async {
    return database!.query(userTable);
  }
}

class UserFields {
  static final String id = 'id';
  static final String UserName = 'UserName';
  static final String DOB = 'DOB';
  static final String Age = 'Age';
  static final String Gender = 'Gender';
  static final String MobileNumber = 'MobileNumber';
  static final String Email = 'Email';
  static final String CityName = 'CityName';
  static final String IsFavorite = 'IsFavorite';
  static final String StateName = 'StateName';
  static final String CountryName = 'CountryName';
}
