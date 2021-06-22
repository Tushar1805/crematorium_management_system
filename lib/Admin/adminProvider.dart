import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/Admin/admin.dart';
import 'package:way_to_heaven/repositories/adminRepository.dart';

enum States { loading, requestInfo }

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
  String selectedSlot = '';

  int selectedRequestIndex;
  int requestCount = 0;
  int currentCount = 0;
  int upcomingCount = 0;

  bool loading = true;

  List<Map> requestList = [];
  List<Map> currentList = [];
  List<Map> upcomingList = [];

  List<DropdownMenuItem<String>> slotsDropdownList = [];
  List<String> slotsStringList = [];

  Map adminMap = {};

  AdminRepository adminRepository = new AdminRepository();

  AdminProvider() {
    getDetails();
  }

  Future<void> getDetails() async {
    loading = true;
    notifyListeners();
    adminMap = await adminRepository.getAdminDetails();
    requestList = await adminRepository.fetchRequestList();
    requestCount = requestList.length;
    setSlots();
    loading = false;
    notifyListeners();
  }

  void setSlots() {
    slotsDropdownList = [];
    slotsStringList = [];

    String opening_time = adminMap['timing']['opening_time'];
    opening_time = opening_time.substring(0, opening_time.length - 2);
    print('opening Time' + opening_time);

    int op_time = int.parse(opening_time);

    int capacity = int.parse(adminMap['capacity']);
    int cremationTime = int.parse(adminMap['cremationTime']);

    print(capacity.toString() + ' ' + cremationTime.toString());

    int t1 = op_time;
    int t2 = (op_time + cremationTime);
    String ts1 =
        (t1 % 12 == 0 ? 12 : t1 % 12).toString() + ((t1 >= 12) ? 'PM' : 'AM');
    String ts2 =
        (t2 % 12 == 0 ? 12 : t2 % 12).toString() + ((t2 >= 12) ? 'PM' : 'AM');
    slotsStringList.add(ts1 + ' - ' + ts2);

    int num = adminMap['slots'].length;
    for (var i = 1; i < num; i++) {
      t1 = t2;
      t2 = (t1 + cremationTime);
      ts1 =
          (t1 % 12 == 0 ? 12 : t1 % 12).toString() + ((t1 > 12) ? 'PM' : 'AM');
      ts2 =
          (t2 % 12 == 0 ? 12 : t2 % 12).toString() + ((t2 > 12) ? 'PM' : 'AM');
      slotsStringList.add(ts1 + ' - ' + ts2);
    }
    notifyListeners();

    // slotsStringList.forEach((element) {
    //   DropdownMenuItem item = DropdownMenuItem(
    //       value: element.toString(), child: Text(element.toString()));
    //   slotsDropdownList.add(item);
    //   notifyListeners();
    // });
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
    await adminRepository.rejectApplication(
        requestList[selectedRequestIndex]['requestId'], reasonForRejection);
    reasonForRejection = '';
    requestList[selectedRequestIndex]['application_status'] = 'rejected';
    print(requestList[selectedRequestIndex]['requestId']);
    notifyListeners();
  }
}
