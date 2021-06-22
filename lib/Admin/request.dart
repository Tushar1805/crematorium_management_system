import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/Admin/loading.dart';
import 'package:way_to_heaven/Admin/requestInfo.dart';
import 'package:way_to_heaven/Admin/showProofOfDeath.dart';
import 'package:way_to_heaven/components/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class RequestPage extends StatefulWidget {
  AdminProvider provider;
  RequestPage(@required this.provider);
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  bool loadingPage = false;
  TimeOfDay time1 = TimeOfDay.now();
  TimeOfDay time2 = TimeOfDay.now();
  TimeOfDay from, till;
  TimeOfDay picked1;
  TimeOfDay picked2;

  String _hour, _minute, _time, selectedSlot;
  int slotIndex;
  TimeOfDay selectedTime1 = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _time1Controller = TextEditingController();

  TextEditingController _time2Controller = TextEditingController();

  void showRejectDialog(AdminProvider provider) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'Reason For Rejection',
              style: lightBlackTextStyle().copyWith(fontSize: 18),
            )),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  autocorrect: true,
                  autofocus: false,
                  decoration: loginInputDecoration()
                      .copyWith(hintText: 'Reason For Rejection'),
                  maxLines: 3,
                  maxLength: 100,
                  onChanged: (value) {
                    provider.reasonForRejection = value;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: FlatButton(
                  onPressed: () {
                    provider.rejectApplication();
                    sleep(Duration(seconds: 2));
                    Navigator.pop(context);
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
                        'SUBMIT',
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

  @override
  Widget build(BuildContext context) {
    Widget Selector(BuildContext context, AdminProvider provider) {
      switch (provider.state) {
        // Changes to be made
        case States.loading:
          return loading();
          break;
        case States.requestInfo:
          return Container(
            height: MediaQuery.of(context).size.height - 71,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.width / 7,
                                  backgroundImage:
                                      AssetImage('assets/icons/user.png'),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Text(
                                  'Applicant Name:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    provider.requestList[
                                            provider.selectedRequestIndex]
                                        ['applicant_name'],
                                    style: normalTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Dead Person\'s Name:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    provider.requestList[
                                            provider.selectedRequestIndex]
                                        ['dead_persons_name'],
                                    style: normalTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Age:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    provider.requestList[
                                            provider.selectedRequestIndex]
                                        ['dead_persons_age'],
                                    style: normalTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Gender:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    provider.requestList[
                                            provider.selectedRequestIndex]
                                        ['selectedGender'],
                                    style: normalTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Cause Of Death:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    provider.requestList[
                                            provider.selectedRequestIndex]
                                        ['cause_of_death'],
                                    style: normalTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Application Time:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    ' ${DateTime.parse(provider.requestList[provider.selectedRequestIndex]['application_time'].toDate().toString()).hour} :  ${DateTime.parse(provider.requestList[provider.selectedRequestIndex]['application_time'].toDate().toString()).minute}',
                                    style: normalTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ViewProofOfDeath(provider)));
                              },
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Color(0xFF00cc66),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 15.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'View Proof Of Death',
                                        style: whiteTextStyle()
                                            .copyWith(fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    provider.requestList[provider.selectedRequestIndex]
                                ['application_status'] !=
                            'rejected'
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Time  Slot  To  Be  Alloted:',
                                      style: lightBlackTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  child: DropdownButtonFormField<String>(
                                    decoration:
                                        formInputDecoration("Select Time Slot"),
                                    items: provider.slotsStringList
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                        onTap: () {
                                          selectedSlot = value;
                                          slotIndex = provider.slotsStringList
                                              .indexOf(value);

                                          print(selectedSlot +
                                              ' ' +
                                              slotIndex.toString());
                                        },
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 30.0,
                    ),
                    provider.requestList[provider.selectedRequestIndex]
                                ['application_status'] ==
                            'rejected'
                        ? Container(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            height: 50.0,
                            decoration: new BoxDecoration(
                              color: redOrangeColor(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'REJECTED',
                                style: whiteTextStyle().copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    loadingPage = true;
                                  });
                                  FirebaseFirestore ref =
                                      FirebaseFirestore.instance;

                                  await ref
                                      .collection('Applications')
                                      .doc(provider.requestList[provider
                                          .selectedRequestIndex]['requestId'])
                                      .update({
                                    'application_status': 'Approved',
                                    'time_slot_alloted': selectedSlot
                                  });
                                  print('aproved');

                                  setState(() {
                                    loadingPage = false;
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      40,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    color: Color(0xFF00cc66),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'APROVE',
                                      style: whiteTextStyle().copyWith(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  showRejectDialog(provider);
                                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForCremation(provider) ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      40,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    color: redOrangeColor(),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'REJECT',
                                      style: whiteTextStyle().copyWith(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ], //  Naviga
                ),
              ),
            ),
          );
          break;
      }
    }

    final provider = widget.provider;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: redOrangeColor(), // status bar color
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light, //status bar brigtness
          ),
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            child: new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 40, bottom: 10.0),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(provider.requestTitle, style: titleBarWhiteTextStyle()),
                ],
              ),
            ),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [redOrangeColor(), redOrangeColor(), orangeColor()]),
            ),
          ),
        ),
        body: loadingPage ? loading() : Selector(context, provider));
  }
}
