import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:way_to_heaven/Admin/adminHomePageBase.dart';
import 'package:way_to_heaven/Admin/completeProfile.dart';
import 'package:way_to_heaven/Admin/loading.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/User/completeProfile.dart';
import 'package:way_to_heaven/User/userHome.dart';
import 'package:way_to_heaven/User/userHomePageBase.dart';
import 'package:way_to_heaven/components/constants.dart';

Widget SetRole(BuildContext context, LoginProvider provider) {
  String role;
  void _showSnackBar() {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 30.0,
        child: Center(
          child: Text(
            'Something went wrong. Please try again...',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: lightBlack(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> _checkRole() async {
    final ref = FirebaseFirestore.instance.collection('Users');
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (!provider.isRoleNotFound) {
        provider.checkRole();
        await ref.doc(user.uid).get().then((value) {
          if (value.data()['role'] == 'Admin' ||
              value.data()['role'] == 'User') {
            role = value.data()['role'];
            if (role == 'User') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserHomePageBase()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminHomePageBase()));
            }
          } else {
            provider.roleNotFound();
          }
        });
      }
    }
  }

  _checkRole();

  return provider.loading
      ? loading()
      : Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text("Register as",
                      style: lightBlackTextStyle().copyWith(fontSize: 20)),
                  decoration: bottomBorder(),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 115,
                        height: 150,
                        child: Center(
                          child: Text(
                            "Admin",
                            style: whiteTextStyle(),
                          ),
                        ),
                        decoration: topBottomGradient(),
                      ),
                      onTap: () async {
                        final ref =
                            FirebaseFirestore.instance.collection('Users');
                        var user = FirebaseAuth.instance.currentUser;
                        provider.checkRole();
                        await ref.doc(user.uid).update({'role': 'Admin'});
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminHomePageBase()));
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 115,
                        height: 150,
                        child: Center(
                          child: Text(
                            "User",
                            style: whiteTextStyle(),
                          ),
                        ),
                        decoration: topBottomGradient(),
                      ),
                      onTap: () async {
                        final ref =
                            FirebaseFirestore.instance.collection('Users');
                        var user = FirebaseAuth.instance.currentUser;
                        provider.checkRole();
                        await ref.doc(user.uid).update({'role': 'User'});
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserHomePageBase()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
}
