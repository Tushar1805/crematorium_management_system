import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Authentication/loginPage.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/Profile/about.dart';
import 'package:way_to_heaven/Profile/editProfile.dart';
import 'package:way_to_heaven/Profile/settings.dart';
import 'package:way_to_heaven/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String name, email, phone, role;

  @override
  void initState() {
    super.initState();
    //getUserInfo();
  }

  // Future<void> getUserInfo() async {
  //   final String uid = _auth.currentUser.uid.toString();
  //   FirebaseFirestore.instance.collection("Users").doc(uid).get().then(
  //     (value) {
  //       setState(() {
  //         role = (value["role"].toString());
  //         print(role);
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final loginPro = Provider.of<LoginProvider>(context);

    Row buildRow(String image, String label) {
      return Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "$image",
              height: 15,
              width: 15,
              color: Colors.grey,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.63,
            // decoration: BoxDecoration(color: Colors.yellow),
            child: Text("$label",
                style: lightBlackTextStyle().copyWith(fontSize: 15)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            // decoration: BoxDecoration(color: Colors.blue),
            child: SvgPicture.asset(
              "Icons/greater.svg",
              height: 20,
              width: 20,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      );
    }

    Row buildRowForSvg(String image, String label) {
      return Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              "$image",
              height: 15,
              width: 15,
              color: Colors.grey,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.63,
            // decoration: BoxDecoration(color: Colors.yellow),
            child: Text("$label",
                style: lightBlackTextStyle().copyWith(fontSize: 15)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            // decoration: BoxDecoration(color: Colors.blue),
            child: SvgPicture.asset(
              "Icons/greater.svg",
              height: 20,
              width: 20,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    splashColor: Colors.transparent,
                    child: Text("EDIT PROFILE",
                        style: orangeTextStyle().copyWith(fontSize: 13)))
              ]),
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/user.png',
                            height: 50,
                          ),
                          SizedBox(width: 15),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tushar",
                                  style: darkBlackTextStyle()
                                      .copyWith(fontSize: 20),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "Email ID ",
                                      style: darkBlackTextStyle()
                                          .copyWith(fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "tusharkalbhande18@gmail.com",
                                      style: lightBlackTextStyle()
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "MOB. ",
                                      style: darkBlackTextStyle()
                                          .copyWith(fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "9579982823",
                                      style: lightBlackTextStyle()
                                          .copyWith(fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Image.asset(
                                      "Icons/checked.png",
                                      width: 10,
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        splashColor: Colors.transparent,
                        child: buildRow("Icons/gear.png", "Settings"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child: buildRow(
                            "Icons/cremation.png", "Crematoriums Available"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child: buildRow("Icons/report.png", "History"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                          onTap: () {},
                          splashColor: Colors.transparent,
                          child: buildRow("Icons/download.png",
                              "Download Acknowledgement")),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child: buildRow("Icons/aboutUs.png", "Example"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUs()));
                        },
                        splashColor: Colors.transparent,
                        child: buildRow("Icons/aboutUs.png", "About Us"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child: buildRowForSvg("Icons/help.svg", "Help"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child:
                            buildRow("Icons/aboutUs.png", "Terms And Services"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(height: 1),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          _auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(context, loginPro)));
                        },
                        splashColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'Icons/logout.png',
                              height: 23,
                              width: 23,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("LOG OUT",
                                style: orangeTextStyle().copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Text("App Version 1.0"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
