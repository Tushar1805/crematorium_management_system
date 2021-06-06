import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/repositories/adminRepository.dart';

class AdminProvider extends ChangeNotifier {
  // Temporary Admin Details
  //
  //
  //
  //
  //
  //
  //
  //
  String adminId = 'jCb6F1p3eH4Ft7pxVvfb';
  bool loading = true;
  List<Map> requestList = [];
  List<Map> currentList = [];
  List<Map> upcomingList = [];

  AdminRepository adminRepository = new AdminRepository();

  AdminProvider() {
    getDetails();
  }

  Future<void> getDetails() async {
    loading = true;
    notifyListeners();
    requestList = await adminRepository.fetchRequestList();
    loading = false;
    notifyListeners();
  }
}
