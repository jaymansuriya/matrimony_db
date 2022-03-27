import 'package:matrimony_db/models/model.dart';

final String userTable = 'Tbl_user';

class UserModel extends Model {
  late int? id;
  late String UserName;
  late String DOB;
  late int Age;
  late int Gender;
  late String? MobileNumber;
  late String? Email;
  late int? IsFavorite;
  late String CityName;
  late String CountryName;
  late String StateName;

  UserModel(
      {this.id,
      required this.UserName,
      required this.DOB,
      required this.Age,
      required this.Gender,
      this.MobileNumber,
      this.Email,
      required this.IsFavorite,
      required this.CityName,
      required this.StateName,
      required this.CountryName});

  static UserModel fromMap(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        UserName: json['UserName'].toString(),
        DOB: json['DOB'].toString(),
        Age: json['Age'],
        Gender: json['Gender'],
        MobileNumber: json['MobileNumber'].toString(),
        Email: json['Email'].toString(),
        IsFavorite: json['IsFavorite'],
        CityName: json['CityName'],
        StateName: json['StateName'],
        CountryName: json['CountryName']);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'UserName': UserName,
      'DOB': DOB,
      'Age': Age,
      'Gender': Gender,
      'MobileNumber': MobileNumber,
      'Email': Email,
      'CityName': CityName,
      'StateName': StateName,
      'CountryName': CountryName,
      'IsFavorite': IsFavorite,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
