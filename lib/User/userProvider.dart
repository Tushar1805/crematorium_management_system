import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/User/user.dart';
import 'package:way_to_heaven/repositories/userRepository.dart';

class UserProvider extends ChangeNotifier {
  String selectedZone;

  // Application

  String applicant_name = 'Rajesh Thakur';
  String dead_persons_name;
  String dead_persons_age;
  String selectedGender;
  String cause_of_death;
  String imageName = '';
  String imageDownloadUrl;
  File image;
  bool isGenderSelected = false;
  bool isImageSelected = false;
  int selectedCrematorium;
  List<String> zonesStringList = [
    'Laxminagar',
    'Dharampeth',
    'Hanuman nagar',
    'Dhantoli',
    'Nehru Nagar',
    'Gandhibagh',
    'Satranjipura',
    'Lakadganj',
    'Ashi Nagar',
    'Mangalwari'
  ];
  List<DropdownMenuItem> zonesDropDownList = [];
  List<Map> crematoriumList = [];
  List<Map> crematoriumSearchList = [];

  UserRepository userRepository = new UserRepository();

  UserProvider() {
    setZones();
    getCrematoriums();
  }

  Future<void> completeUserProfile(UserClass user, String uid) async {
    final docTodo = FirebaseFirestore.instance.collection('Users').doc(uid);

    await docTodo.set(user.toJson());
  }

  void getCrematoriums() async {
    crematoriumList = await userRepository.getCrematoriums();
    crematoriumSearchList = crematoriumList;
    notifyListeners();
    // print(crematoriumList);
  }

  void setZones() {
    zonesDropDownList = [];
    zonesStringList.forEach((element) {
      DropdownMenuItem item = DropdownMenuItem(
          value: element.toString(), child: Text(element.toString()));
      zonesDropDownList.add(item);
      notifyListeners();
    });
  }

  void selectZone(String val) {
    selectedZone = val;
    crematoriumSearchList = [];
    crematoriumList.forEach((element) {
      if (element['zone'] == selectedZone) {
        crematoriumSearchList.add(element);
      }
    });
    notifyListeners();
  }

  // Application For Crematorium

  void selectCrematorium(int index) {
    selectedCrematorium = index;
    notifyListeners();
  }

  void selectGenderClicked(String gender) {
    selectedGender = gender;
    isGenderSelected = true;
    print(gender);
    notifyListeners();
  }

  Future<void> addImage(String path) {
    image = File(path);
    imageName = basename(image.path);
    isImageSelected = true;
    notifyListeners();
  }

  void deleteImage() {
    image = null;
    imageName = '';
    isImageSelected = false;
    notifyListeners();
  }

  Future<void> uploadImage() async {
    String name = 'applicationImages/' + DateTime.now().toIso8601String();
    await FirebaseStorage.instance.ref(name).putFile(image);
    String url = await FirebaseStorage.instance.ref(name).getDownloadURL();
    imageDownloadUrl = url;
  }

  Future<bool> submitApplicationToCrematorium() async {
    print(dead_persons_name);
    print(dead_persons_age);
    print(cause_of_death);
    print(isGenderSelected);
    if ((dead_persons_name != null && dead_persons_name != '') &&
        (dead_persons_age != null && dead_persons_age != '') &&
        (cause_of_death != null && cause_of_death != '') &&
        isGenderSelected &&
        isImageSelected) {
      Map crematoriumMap = crematoriumSearchList[selectedCrematorium];
      await uploadImage();
      await userRepository.submitApplication(
          applicant_name,
          dead_persons_name,
          dead_persons_age,
          selectedGender,
          cause_of_death,
          crematoriumMap,
          imageDownloadUrl);
      dead_persons_name = '';
      dead_persons_age = '';
      cause_of_death = '';
      selectedGender = '';
      return true;
    } else {
      return false;
    }
  }
}
