import 'dart:io';

import 'package:flutter/material.dart';
import 'package:way_to_heaven/repositories/userRepository.dart';

class UserProvider extends ChangeNotifier {
  String selectedZone;

  // Application

  String applicant_name = 'Rajesh Thakur';
  String dead_persons_name;
  String dead_persons_age;
  String selectedGender;
  String cause_of_death;
  File image;
  bool isGenderSelected = false;

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

  void addImage(String path) {
    image = File(path);
    notifyListeners();
  }

  Future<bool> submitApplicationToCrematorium() async {
    print(dead_persons_name);
    print(dead_persons_age);
    print(cause_of_death);
    print(isGenderSelected);
    if ((dead_persons_name != null && dead_persons_name != '') &&
        (dead_persons_age != null && dead_persons_age != '') &&
        (cause_of_death != null && cause_of_death != '') &&
        isGenderSelected) {
      Map crematoriumMap = crematoriumSearchList[selectedCrematorium];
      await userRepository.submitApplication(applicant_name, dead_persons_name,
          dead_persons_age, selectedGender, cause_of_death, crematoriumMap);
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
