import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/User/showProofOfDeath.dart';
import 'package:way_to_heaven/User/userProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class ApplicationStatusCheck extends StatefulWidget {
  UserProvider provider;
  ApplicationStatusCheck(@required this.provider);
  @override
  _ApplicationStatusCheckState createState() => _ApplicationStatusCheckState();
}

class _ApplicationStatusCheckState extends State<ApplicationStatusCheck> {
  @override
  Widget build(BuildContext context) {
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
                Text('Application Status', style: titleBarWhiteTextStyle()),
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
      body: Container(
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
                              provider.applicationList[provider
                                  .selectedRequestIndex]['applicant_name'],
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
                              provider.applicationList[provider
                                  .selectedRequestIndex]['dead_persons_name'],
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
                              provider.applicationList[provider
                                  .selectedRequestIndex]['dead_persons_age'],
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
                              provider.applicationList[provider
                                  .selectedRequestIndex]['selectedGender'],
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
                              provider.applicationList[provider
                                  .selectedRequestIndex]['cause_of_death'],
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
                              ' ${DateTime.parse(provider.applicationList[provider.selectedRequestIndex]['application_time'].toDate().toString()).hour} :  ${DateTime.parse(provider.applicationList[provider.selectedRequestIndex]['application_time'].toDate().toString()).minute}',
                              style: normalTextStyle()),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      provider.applicationList[provider.selectedRequestIndex]
                                  ['time_slot_alloted'] !=
                              null
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Slot Alloted:',
                                      style: lightBlackTextStyle(),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        provider.applicationList[
                                                provider.selectedRequestIndex]
                                            ['time_slot_alloted'],
                                        style: normalTextStyle()),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 0.0,
                            ),
                      Row(
                        children: [
                          Text(
                            'Application Status:',
                            style: lightBlackTextStyle(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              provider.applicationList[provider
                                  .selectedRequestIndex]['application_status'],
                              style: normalTextStyle().copyWith(
                                  color: provider.applicationList[
                                                  provider.selectedRequestIndex]
                                              ['application_status'] ==
                                          'Approved'
                                      ? Color(0xFF00cc66)
                                      : provider.applicationList[provider
                                                      .selectedRequestIndex]
                                                  ['application_status'] ==
                                              'rejected'
                                          ? Color(0xFFff0000)
                                          : Colors.amber,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      provider.applicationList[provider.selectedRequestIndex]
                                  ['reason_for_rejection'] !=
                              null
                          ? Row(
                              children: [
                                Text(
                                  'Reason For Rejection:',
                                  style: lightBlackTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    provider.applicationList[
                                            provider.selectedRequestIndex]
                                        ['reason_for_rejection'],
                                    style: normalTextStyle().copyWith(
                                        color: Color(0xFFf44336),
                                        fontWeight: FontWeight.w600)),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 30.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ViewProofOfDeath(provider)));
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
                                  style:
                                      whiteTextStyle().copyWith(fontSize: 14.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
