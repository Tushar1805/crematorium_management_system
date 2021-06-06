import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/repositories/adminRepository.dart';

enum States { loading, requestInfo, showProofOfDeath }

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
  String selectedRequestId;
  var state = States.requestInfo;
  String requestTitle = 'Request';
  int selectedRequestIndex;
  int requestCount = 0;
  int currentCount = 0;
  int upcomingCount = 0;
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
    requestCount = requestList.length;
    loading = false;
    notifyListeners();
  }

  void requestSelected(String requestId, int index) {
    state = States.requestInfo;
    selectedRequestId = requestId;
    selectedRequestIndex = index;
    print(selectedRequestId);
    notifyListeners();
  }

  void showProofOfDeath() {
    state = States.showProofOfDeath;
    requestTitle = 'Proof Of Death';
    notifyListeners();
  }
}
