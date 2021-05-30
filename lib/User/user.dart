import 'package:way_to_heaven/utils/utils.dart';

class User {
  String name, role, address, mobile, email, age;
  bool isNewUser;
  DateTime createdTime;

  User(
      {this.name,
      this.createdTime,
      this.role,
      this.address,
      this.mobile,
      this.age,
      this.isNewUser = true});

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdTime': createdTime,
        'role': role,
        'address': address,
        'age': age,
        'newUser': isNewUser
      };

  static User fromJson(Map<String, dynamic> json) => User(
        createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        role: json['role'],
        address: json['address'],
        age: json['age'],
        isNewUser: json['newUser'],
      );
}
