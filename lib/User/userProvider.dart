import 'dart:io';

import 'package:flutter/material.dart';
import 'package:way_to_heaven/repositories/userRepository.dart';

class UserProvider extends ChangeNotifier{

  String selectedZone ;
  int selectedCrematorium ;
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
  List<Map> crematoriumList = [] ;
  List<Map> crematoriumSearchList = [] ;

  List<File> image = [];

  UserRepository userRepository = new UserRepository();

  UserProvider(){
    setZones();
    getCrematoriums();
  }

  void getCrematoriums() async {
    crematoriumList = await userRepository.getCrematoriums();
    crematoriumSearchList = crematoriumList ;
    notifyListeners();
    // print(crematoriumList);
  }

  void setZones(){
    zonesDropDownList = [];
    zonesStringList.forEach((element) { 
      DropdownMenuItem item = DropdownMenuItem( value: element.toString(), child: Text(element.toString()));
      zonesDropDownList.add(item);
      notifyListeners();
    });
  }

  void selectZone(String val){
    selectedZone = val;
    crematoriumSearchList = [];
    crematoriumList.forEach((element) {
      if(element['zone'] == selectedZone){
        crematoriumSearchList.add(element);
      }
    });
    notifyListeners();
  }
  
  void selectCrematorium(int index){
    selectedCrematorium = index;
    notifyListeners();
  }

  void addImage(String path) {
    image.add(File(path));
    notifyListeners();
  }
}