import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/components/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
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
          "Settings",
          style: whiteTextStyle().copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Text("This is the Edit Settings Page"),
        ),
      ),
    );
  }
}
