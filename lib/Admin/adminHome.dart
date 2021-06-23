import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Admin/Profile/adminProfileBase.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/Admin/completeProfile.dart';
import 'package:way_to_heaven/Admin/loading.dart';
import 'package:way_to_heaven/Admin/request.dart';
import 'package:way_to_heaven/Admin/upcomingRequestInfo.dart';
import 'package:way_to_heaven/components/constants.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool loadingPage = true;

  @override
  void initState() {
    super.initState();
    print('init');
    _checkProfile();
  }

  void showCompleteProfileDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'Warning',
              style: lightBlackTextStyle().copyWith(fontSize: 18),
            )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Complete your profile!'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CompleteAdminProfile()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            redOrangeColor(),
                            redOrangeColor(),
                            orangeColor()
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'OK',
                        style: whiteTextStyle().copyWith(
                            fontSize: 15.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  Future<void> _checkProfile() async {
    setState(() {
      loadingPage = true;
    });
    print('enter');
    final ref = FirebaseFirestore.instance.collection('Users');
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('user not null');
      await ref.doc(user.uid).get().then((value) {
        if (value.data()['crematoriumName'] == null) {
          setState(() {
            loadingPage = false;
          });
          print('exit');
          showCompleteProfileDialog();
        } else {
          setState(() {
            loadingPage = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return loadingPage
        ? loading()
        : DefaultTabController(
            length: 3,
            child: Stack(children: [
              Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        child: InkWell(
                          highlightColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminProfileBase()));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/user.png',
                                height: 35,
                              ),
                              SizedBox(width: 15),
                              Text(
                                provider.adminMap['name'] ?? 'Admin',
                                style: lightBlackTextStyle()
                                    .copyWith(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/bell.png',
                        height: 22,
                        width: 22,
                        color: Color(0xFF929292),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 50,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white, // status bar color
                      statusBarBrightness:
                          Brightness.light, //status bar brigtness
                    ),
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Request'),
                              provider.requestCount > 0
                                  ? Badge(
                                      badgeColor: Colors.white,
                                      badgeContent: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          provider.requestCount.toString(),
                                          style: whiteTextStyle().copyWith(
                                              color: redOrangeColor(),
                                              fontSize: 13.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Current'),
                              provider.currentCount > 0
                                  ? Badge(
                                      badgeColor: Colors.white,
                                      badgeContent: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          provider.currentCount.toString(),
                                          style: whiteTextStyle().copyWith(
                                              color: redOrangeColor(),
                                              fontSize: 13.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Upcoming'),
                              provider.upcomingCount > 0
                                  ? Badge(
                                      badgeColor: Colors.white,
                                      badgeContent: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          provider.upcomingCount.toString(),
                                          style: whiteTextStyle().copyWith(
                                              color: redOrangeColor(),
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        )
                      ],
                      onTap: (index) {
                        print(index);
                      },
                      labelStyle: normalTextStyle().copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      indicatorPadding: EdgeInsets.only(bottom: 2, top: 0),
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 10.0)),
                    ),
                    backgroundColor: orangeColor(),
                  ),
                  body: TabBarView(
                    children: [
                      Container(
                        color: Color(0xFFeeeef0),
                        padding: EdgeInsets.all(10.0),
                        child: provider.requestList.length > 0
                            ? provider.loading
                                ? SpinKitThreeBounce(
                                    color: redOrangeColor(),
                                    size: 40.0,
                                  )
                                : ListView.builder(
                                    itemCount: provider.requestList.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 0.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      provider.requestList[
                                                              index]
                                                          ['applicant_name'],
                                                      style:
                                                          darkBlackTextStyle()),
                                                  Spacer(),
                                                  Text(
                                                      ' ${DateTime.parse(provider.requestList[index]['application_time'].toDate().toString()).hour % 12} :  ${DateTime.parse(provider.requestList[index]['application_time'].toDate().toString()).minute} ${(DateTime.parse(provider.requestList[index]['application_time'].toDate().toString()).hour > 12 ? 'PM' : 'AM')}'),
                                                  SizedBox(
                                                    width: 20.0,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text("cause Of Death:",
                                                        style:
                                                            normalTextStyle()),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                        provider.requestList[
                                                                index]
                                                            ['cause_of_death'],
                                                        style:
                                                            lightBlackTextStyle()),
                                                    Spacer(),
                                                    FlatButton(
                                                      onPressed: () {
                                                        provider.requestSelected(
                                                            provider.requestList[
                                                                    index]
                                                                ['requestId'],
                                                            index);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    RequestPage(
                                                                        provider)));
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        height: 30.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  redOrangeColor()),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'DETAILS',
                                                            style: whiteTextStyle()
                                                                .copyWith(
                                                                    color:
                                                                        redOrangeColor(),
                                                                    fontSize:
                                                                        13.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ])
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                            : Center(
                                child: Text(
                                    'You don\'t have any request\'s yet.')),
                      ),
                      Container(
                          color: Color(0xFFeeeef0),
                          child: provider.currentList.length > 0
                              ? provider.loading
                                  ? SpinKitThreeBounce(
                                      color: redOrangeColor(),
                                      size: 40.0,
                                    )
                                  : ListView.builder(
                                      itemCount: provider.currentList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        provider.currentList[
                                                                index]
                                                            ['applicant_name'],
                                                        style:
                                                            darkBlackTextStyle()),
                                                    Spacer(),
                                                    Text(
                                                        ' ${DateTime.parse(provider.currentList[index]['application_time'].toDate().toString()).hour % 12} :  ${DateTime.parse(provider.currentList[index]['application_time'].toDate().toString()).minute} ${(DateTime.parse(provider.currentList[index]['application_time'].toDate().toString()).hour > 12 ? 'PM' : 'AM')}'),
                                                    SizedBox(
                                                      width: 20.0,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("cause Of Death:",
                                                          style:
                                                              normalTextStyle()),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                          provider.currentList[
                                                                  index][
                                                              'cause_of_death'],
                                                          style:
                                                              lightBlackTextStyle()),
                                                      Spacer(),
                                                      FlatButton(
                                                        onPressed: () {
                                                          provider.upcomingRequestSelected(
                                                              provider.currentList[
                                                                      index]
                                                                  ['requestId'],
                                                              index);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      UpcomingRequestPage(
                                                                          provider)));
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          height: 30.0,
                                                          decoration:
                                                              new BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    redOrangeColor()),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  2.0),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'DETAILS',
                                                              style: whiteTextStyle().copyWith(
                                                                  color:
                                                                      redOrangeColor(),
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ])
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                              : Center(
                                  child: Text(
                                      'You don\'t have current cremations.\'s yet.'))),
                      Container(
                          color: Color(0xFFeeeef0),
                          child: provider.upcomingList.length > 0
                              ? provider.loading
                                  ? SpinKitThreeBounce(
                                      color: redOrangeColor(),
                                      size: 40.0,
                                    )
                                  : ListView.builder(
                                      itemCount: provider.upcomingList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        provider.upcomingList[
                                                                index]
                                                            ['applicant_name'],
                                                        style:
                                                            darkBlackTextStyle()),
                                                    Spacer(),
                                                    Text(
                                                        ' ${DateTime.parse(provider.upcomingList[index]['application_time'].toDate().toString()).hour % 12} :  ${DateTime.parse(provider.upcomingList[index]['application_time'].toDate().toString()).minute} ${(DateTime.parse(provider.upcomingList[index]['application_time'].toDate().toString()).hour > 12 ? 'PM' : 'AM')}'),
                                                    SizedBox(
                                                      width: 20.0,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("cause Of Death:",
                                                          style:
                                                              normalTextStyle()),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                          provider.upcomingList[
                                                                  index][
                                                              'cause_of_death'],
                                                          style:
                                                              lightBlackTextStyle()),
                                                      Spacer(),
                                                      FlatButton(
                                                        onPressed: () {
                                                          provider.upcomingRequestSelected(
                                                              provider.upcomingList[
                                                                      index]
                                                                  ['requestId'],
                                                              index);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      UpcomingRequestPage(
                                                                          provider)));
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          height: 30.0,
                                                          decoration:
                                                              new BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    redOrangeColor()),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  2.0),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'DETAILS',
                                                              style: whiteTextStyle().copyWith(
                                                                  color:
                                                                      redOrangeColor(),
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ])
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                              : Center(
                                  child: Text(
                                      'You don\'t have upcoming cremations.\'s yet.'))),
                    ],
                  ),
                ),
              ),
            ]),
          );
  }
}
