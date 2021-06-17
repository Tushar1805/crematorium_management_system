import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:way_to_heaven/repositories/loginRepository.dart';

enum States { loginScreen, otpVerification, selectRole, loading }

class LoginProvider extends ChangeNotifier {
  var state;
  String number;
  String status = ' ';
  String uid;
  bool isNewUser = true;
  bool isRoleNotFound = false;

  // LoginRepository loginRepository = new LoginRepository();

  final ref = FirebaseFirestore.instance.collection('Users');
  var user = FirebaseAuth.instance.currentUser;

  LoginProvider() {
    state = States.loading;
    if (user != null) {
      state = States.selectRole;
      notifyListeners();
    } else {
      state = States.loginScreen;
      notifyListeners();
    }
    print("state enabled");
  }

  void changeStatus(dynamic val) {
    state = val;
    notifyListeners();
  }

  Future<void> otpVerified() async {
    state = States.selectRole;
    uid = await LoginRepository().getUid();
    notifyListeners();
  }

  void numberEntered() {
    state = States.otpVerification;
    notifyListeners();
  }

  void checkRole() {
    state = States.loading;
    notifyListeners();
  }

  void roleNotFound() {
    isRoleNotFound = true;
    state = States.selectRole;
    notifyListeners();
  }
}
