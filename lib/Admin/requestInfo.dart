import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

Widget requestInfo(AdminProvider provider, BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
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
                        provider.requestList[provider.selectedRequestIndex]
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
                        provider.requestList[provider.selectedRequestIndex]
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
                        provider.requestList[provider.selectedRequestIndex]
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
                        provider.requestList[provider.selectedRequestIndex]
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
                        provider.requestList[provider.selectedRequestIndex]
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
                    provider.showProofOfDeath();
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
                            style: whiteTextStyle().copyWith(fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      'Time To Be Alloted:',
                      style: lightBlackTextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          Spacer(),
          FlatButton(
            onPressed: () {
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForCremation(provider) ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
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
                  Radius.circular(5.0),
                ),
              ),
              child: Center(
                child: Text(
                  'APROVE',
                  style: whiteTextStyle()
                      .copyWith(fontSize: 15.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ], //  Naviga
      ),
    ),
  );
}
