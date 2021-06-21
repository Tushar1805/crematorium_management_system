import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_heaven/utils/utils.dart';

class AdminClass {
  String name,
      email,
      address,
      age,
      contact,
      role,
      crematoriumName,
      crematoriumContact,
      capacity,
      cremationTime;
  bool isNewUser;
  DateTime createdTime;
  Map<String, dynamic> timing;
  LatLng location;

  AdminClass(
      {this.name,
      this.createdTime,
      this.email,
      this.address,
      this.age,
      this.contact,
      this.role,
      this.crematoriumName,
      this.crematoriumContact,
      this.capacity,
      this.cremationTime,
      this.timing,
      this.location,
      this.isNewUser = false});

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdTime': DateTime.now(),
        'email': email,
        'address': address,
        'age': age,
        'contact': contact,
        'role': role,
        'crematoriumName': crematoriumName,
        'crematoriumContact': crematoriumContact,
        'cremationTime': createdTime,
        'capacity': capacity,
        'newUser': isNewUser,
        'timing': timing,
        'location': location,
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
        crematoriumContact: json["crematoriumContact"],
        cremationTime: json['cremationTime'],
        capacity: json["capacity"],
        timing: json["timing"],
        location: json['location'],
        isNewUser: json['newUser'],
      );
}
