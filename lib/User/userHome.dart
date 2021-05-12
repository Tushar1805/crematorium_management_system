import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/components/constants.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified_user),
                    SizedBox(width: 10),
                    Text(
                      "Shubham",
                      style: lightBlackTextStyle(),
                    )
                  ],
                ),
                Icon(Icons.notification_important)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white, // status bar color
                statusBarBrightness: Brightness.light, //status bar brigtness
              ),
              bottom: TabBar(
                tabs: [Tab(text: "Crematoriums"), Tab(text: "Applications")],
                indicatorPadding: EdgeInsets.only(bottom: 2),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 45.0)),
              ),
              backgroundColor: orangeColor(),
            ),
            body: TabBarView(
              children: [
                Container(child: Center(child: Text("First Tab"))),
                Container(child: Center(child: Text("Second Tab"))),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
