import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/Admin/showProofOfDeath.dart';
import 'package:way_to_heaven/components/constants.dart';

Widget requestInfo(AdminProvider provider, BuildContext context) {
  TimeOfDay time1;
  TimeOfDay time2;
  TimeOfDay from, till;
  TimeOfDay picked1;
  TimeOfDay picked2;
  Future<Null> selectTime1(BuildContext context) async {
    picked1 = await showTimePicker(context: context, initialTime: time1);

    if (picked1 != null) {
      // setState(() {
      time1 = picked1;
      from = time1;
      // });
    }
  }

  Future<Null> selectTime2(BuildContext context) async {
    picked2 = await showTimePicker(context: context, initialTime: time2);

    if (picked2 != null) {
      // setState(() {
      time2 = picked2;
      till = time2;
      // });
    }
  }

  return SingleChildScrollView(
    child: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 93,
      width: MediaQuery.of(context).size.width,
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
                          backgroundImage: AssetImage('assets/icons/user.png'),
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
                        Text(provider.requestList[provider.selectedRequestIndex]['applicant_name'], style: normalTextStyle()),
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
                        Text(provider.requestList[provider.selectedRequestIndex]['dead_persons_name'], style: normalTextStyle()),
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
                        Text(provider.requestList[provider.selectedRequestIndex]['dead_persons_age'], style: normalTextStyle()),
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
                        Text(provider.requestList[provider.selectedRequestIndex]['selectedGender'], style: normalTextStyle()),
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
                        Text(provider.requestList[provider.selectedRequestIndex]['cause_of_death'], style: normalTextStyle()),
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
                            ' ${DateTime.parse(provider.requestList[provider.selectedRequestIndex]['application_time'].toDate().toString()).hour} :  ${DateTime.parse(provider.requestList[provider.selectedRequestIndex]['application_time'].toDate().toString()).minute} ${(DateTime.parse(provider.requestList[provider.selectedRequestIndex]['application_time']).hour > 12 ? 'PM' : 'AM')}',
                            style: normalTextStyle()),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ViewProofOfDeath(provider)));
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Color(0xFF00cc66),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
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
            ),
            Container(
              child: DropdownButtonFormField<String>(
                decoration: formInputDecoration("Select Time for one Cremation in hour"),
                items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value + " Hr"),
                    onTap: () {
                      String cremationTime;
                      cremationTime = value;
                      print(cremationTime);
                    },
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForCremation(provider) ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
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
                        style: whiteTextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForCremation(provider) ));
                  },
                  child: Container(
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
                        'REJECT',
                        style: whiteTextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ], //  Naviga
        ),
      ),
    ),
  );
}
