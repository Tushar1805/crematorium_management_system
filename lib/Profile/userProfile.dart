import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:way_to_heaven/Admin/completeProfile.dart';
import 'package:way_to_heaven/Profile/about.dart';
import 'package:way_to_heaven/Profile/editProfile.dart';
import 'package:way_to_heaven/Profile/settings.dart';
import 'package:way_to_heaven/User/completeProfile.dart';
import 'package:way_to_heaven/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:way_to_heaven/repositories/loginRepository.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String name, email, phone, role, uid;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    uid = LoginRepository().getUserUid().toString();
  }

  Future<void> getUserInfo() async {
    // final User user = auth.currentUser;
    // await user?.reload();
    // final uid = user.uid;
    FirebaseFirestore.instance.collection("Users").doc(uid).get().then(
      (value) {
        setState(() {
          role = (value["role"].toString());
          phone = (value["mobile"].toString());
          print(role);
          print(phone);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 50.0, bottom: 30.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/icons/user.png',
                    height: 50,
                  ),
                  SizedBox(width: 20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Tushar",
                              style: darkBlackTextStyle().copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 80.0,
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()));
                                },
                                splashColor: Colors.transparent,
                                child: Text("EDIT PROFILE",
                                    style: orangeTextStyle()
                                        .copyWith(fontSize: 13)))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Email ID ",
                              style:
                                  lightBlackTextStyle().copyWith(fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "tusharkalbhande18@gmail.com",
                              style: normalTextStyle().copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "MOB. ",
                              style:
                                  lightBlackTextStyle().copyWith(fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "9579982823",
                              style: normalTextStyle().copyWith(fontSize: 13),
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
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Card(
                shadowColor: Color(0xfff5f5f5),
                elevation: 0.0,
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
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "Icons/gear.png",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Settings", style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                            SizedBox(
                              width: 20,
                            ),
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
                                style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              'Icons/report.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("History", style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                            SizedBox(
                              width: 20,
                            ),
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
                                style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                        onTap: () {
                          if (role == "Admin") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CompleteAdminProfile()));
                          } else if (role == "User") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CompleteUserProfile()));
                          }
                        },
                        splashColor: Colors.transparent,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              'Icons/completeProfile.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Complete Profile",
                                style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                shadowColor: Color(0xfff5f5f5),
                elevation: 0.0,
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
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              'Icons/aboutUs.png',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("About Us", style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(
                              'Icons/help.svg',
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Help", style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                            SizedBox(
                              width: 20,
                            ),
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
                                style: lightBlackTextStyle()),
                            Spacer(),
                            SvgPicture.asset(
                              "Icons/greater.svg",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
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
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("LOG OUT", style: orangeTextStyle()),
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
