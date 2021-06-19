import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/Admin/admin.dart';
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

  var state = States.requestInfo;

  String adminId = 'jCb6F1p3eH4Ft7pxVvfb';
  String selectedRequestId;
  String requestTitle = 'Request';
  String imageUrl;
  String reasonForRejection = '';

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
    imageUrl = requestList[selectedRequestIndex]['imageUrl'];
    print(selectedRequestId);
    notifyListeners();
  }

  Future<void> rejectApplication() async {
    print(selectedRequestId + reasonForRejection);
    await adminRepository.rejectApplication(requestList[selectedRequestIndex]['requestId'], reasonForRejection);
    reasonForRejection = '';
    requestList[selectedRequestIndex]['application_status'] = 'rejected';
    print(requestList[selectedRequestIndex]['requestId']);
    notifyListeners();
  }
}
