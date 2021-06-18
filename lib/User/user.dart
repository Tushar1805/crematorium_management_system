import 'package:way_to_heaven/utils/utils.dart';

class UserClass {
  String name, role, address, mobile, email, age, gender;
  bool isNewUser;
  DateTime createdTime;

  UserClass(
      {this.name,
      this.createdTime,
      this.role,
      this.address,
      this.mobile,
      this.age,
      this.gender,
      this.isNewUser = true});

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdTime': DateTime.now(),
        'role': role,
        'address': address,
        'age': age,
        'gender': gender,
        'newUser': isNewUser
      };

  static UserClass fromJson(Map<String, dynamic> json) => UserClass(
        createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        role: json['role'],
        address: json['address'],
        age: json['age'],
        gender: json['gender'],
        isNewUser: json['newUser'],
      );
}
