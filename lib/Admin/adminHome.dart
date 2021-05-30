import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return DefaultTabController(
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
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/user.png',
                      height: 35,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Admin",
                      style: lightBlackTextStyle().copyWith(fontSize: 17),
                    )
                  ],
                ),
                Icon(
                  Icons.notifications_none_rounded,
                  size: 20,
                  color: Color(0xFF929292),
                )
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
                statusBarBrightness: Brightness.light, //status bar brigtness
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Request",
                  ),
                  Tab(text: "Current"),
                  Tab(text: "Upcoming")
                ],
                onTap: (index) {
                  print(index);
                },
                labelStyle: normalTextStyle().copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                indicatorPadding: EdgeInsets.only(bottom: 2, top: 0),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 20.0)),
              ),
              backgroundColor: orangeColor(),
            ),
            body: TabBarView(
              children: [
                Container(
                    color: Color(0xFFeeeef0),
                    padding: EdgeInsets.all(10.0),
                    child: provider.loading
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
                                      left: 20.0, top: 10.0, bottom: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              provider.requestList[index]
                                                  ['applicant_name'],
                                              style: darkBlackTextStyle()),
                                          Spacer(),
                                          Text(
                                              ' ${DateTime.parse(provider.requestList[index]['application_time'].toDate().toString()).hour} :  ${DateTime.parse(provider.requestList[index]['application_time'].toDate().toString()).minute}'),
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
                                                style: normalTextStyle()),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                                provider.requestList[index]
                                                    ['cause_of_death'],
                                                style: lightBlackTextStyle()),
                                            Spacer(),
                                            FlatButton(
                                              onPressed: () async {},
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                height: 30.0,
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                      color: redOrangeColor()),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(2.0),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'DETAILS',
                                                    style: whiteTextStyle()
                                                        .copyWith(
                                                            color:
                                                                redOrangeColor(),
                                                            fontSize: 15.0,
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
                            })),
                Container(
                    child: Center(
                        child:
                            Text("Current Tab", style: lightBlackTextStyle()))),
                Container(
                    child: Center(
                        child:
                            Text("Upcoming Tab", style: lightBlackTextStyle())))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
