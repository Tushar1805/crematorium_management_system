import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/components/constants.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: redOrangeColor(), // status bar color
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light, //status bar brigtness
        ),
        title: Text(
          "About Us",
          style: whiteTextStyle().copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Text("This is the Edit About Us Page"),
        ),
      ),
    );
  }
}
