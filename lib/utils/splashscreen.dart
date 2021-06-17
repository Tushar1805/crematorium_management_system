import 'dart:async';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/utils/customRouterBase.dart';

import 'customRouterBase.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomRouterBase())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Image.asset('Icons/app_inner_logo.png',
              width: MediaQuery.of(context).size.width / 2, height: MediaQuery.of(context).size.width / 2),
        ));
  }
}
