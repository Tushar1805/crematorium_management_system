import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:way_to_heaven/Admin/adminHome.dart';
import 'package:way_to_heaven/Admin/completeProfile.dart';
import 'package:way_to_heaven/Authentication/loginPage.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/Authentication/setRole.dart';
import 'package:way_to_heaven/Authentication/verifyOTP.dart';
import 'package:way_to_heaven/User/completeProfile.dart';
import 'package:way_to_heaven/User/userHome.dart';

class CustomRouter extends StatefulWidget {
  @override
  _CustomRouterState createState() => _CustomRouterState();
}

class _CustomRouterState extends State<CustomRouter> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    User user = Provider.of<User>(context);

    Widget Selector(BuildContext context, provider) {
      switch (provider.state) {
        case States.loginScreen:
          return LoginPage(context, provider);
          break;
        case States.otpVerification:
          return VerifyOTP(context, provider);
          break;
        case States.selectRole:
          return SetRole(context, provider);
          break;
      }
    }

    if (user != null) {
      provider.state = States.selectRole;
    } else {
      provider.state = States.loginScreen;
    }
    return Scaffold(
      body: Selector(context, provider),
    );
  }
}
