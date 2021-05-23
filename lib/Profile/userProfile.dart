import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;

  String name, email, phone, role;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final User user = auth.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then(
      (value) {
        setState(() {
          role = (value["role"].toString());
          print(role);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.all(10),
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
                        child: Row(
                          children: [
                            Image.asset(
                              "Icons/gear.png",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Settings",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 200,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                        child: Row(
                          children: [
                            Image.asset(
                              "Icons/cremation.png",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Crematoriums Available",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 105,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                        child: Row(
                          children: [
                            Image.asset(
                              'Icons/report.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("History",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 205,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                        child: Row(
                          children: [
                            Image.asset(
                              'Icons/download.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Download Acknowledgement",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 70,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                  padding: EdgeInsets.all(10),
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
                        child: Row(
                          children: [
                            Image.asset(
                              'Icons/aboutUs.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("About Us",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 195,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'Icons/help.svg',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Help",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 222,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                        child: Row(
                          children: [
                            Image.asset(
                              'Icons/aboutUs.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Terms And Services",
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 15)),
                            SizedBox(
                              width: 133,
                            ),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
          ],
        ),
      ),
    );
  }
}
