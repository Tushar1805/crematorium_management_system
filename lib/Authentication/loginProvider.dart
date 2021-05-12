import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:way_to_heaven/repositories/loginRepository.dart';

enum States { loginScreen, otpVerification, selectRole }

class LoginProvider extends ChangeNotifier {
  var state;
  String number;
  String status = ' ';
  String uid;

  LoginRepository loginRepository = new LoginRepository();

  Stream<User> getUsers() {
    return FirebaseAuth.instance.authStateChanges();
  }

  LoginProvider() {
    state = States.loginScreen;
    uid = loginRepository.getUid();
    print("state enabled");
  }

  void changeStatus(dynamic val) {
    state = val;
    notifyListeners();
  }

  Future<void> otpVerified() async {
    state = States.selectRole;
    uid = await loginRepository.getUid();
    notifyListeners();
  }

  void numberEntered() {
    state = States.otpVerification;
    notifyListeners();
  }
}
