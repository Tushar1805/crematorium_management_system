import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/utils/utils.dart';

class AdminClass {
  String name, email, address, age, contact, role, crematoriumName, capacity;
  bool isNewUser;
  DateTime createdTime;
  Map<String, TimeOfDay> timing;

  AdminClass(
      {this.name,
      this.createdTime,
      this.email,
      this.address,
      this.age,
      this.contact,
      this.role,
      this.crematoriumName,
      this.capacity,
      this.timing,
      this.isNewUser = true});

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdTime': DateTime.now(),
        'email': email,
        'address': address,
        'age': age,
        'contact': contact,
        'role': role,
        'crematoriumName': crematoriumName,
        'capacity': capacity,
        'newUser': isNewUser,
        'timing': timing,
      };

  static AdminClass fromJson(Map<String, dynamic> json) => AdminClass(
        createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        email: json["email"],
        address: json['address'],
        age: json['age'],
        contact: json["contact"],
        role: json['role'],
        crematoriumName: json["crematoriumName"],
        capacity: json["capacity"],
        timing: json["timing"],
        isNewUser: json['newUser'],
      );
}
