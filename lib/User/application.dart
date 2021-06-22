import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/User/apply.dart';
import 'package:way_to_heaven/User/userProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class Application extends StatefulWidget {
  UserProvider provider;
  Application(@required this.provider);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: redOrangeColor(),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
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
                  Text('Crematorium Details', style: titleBarWhiteTextStyle()),
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
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 4,
                              backgroundImage: AssetImage('assets/icons/image_placeholder.png'),
                            ),
                            // Container(
                            //     width: MediaQuery.of(context).size.width / 2,
                            //     height: MediaQuery.of(context).size.width / 2,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(90.0), border: Border.all(color: Color(0xFFeeeeee))),
                            //     child: Image.asset('assets/icons/image_placeholder.png'))
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Text(
                              'Crematorium Name:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(provider.crematoriumSearchList[provider.selectedCrematorium]['crematoriumName'],
                                style: normalTextStyle()),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Zone:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(provider.crematoriumSearchList[provider.selectedCrematorium]['zone'], style: normalTextStyle()),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Address:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(provider.crematoriumSearchList[provider.selectedCrematorium]['zone'], style: normalTextStyle()),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Timings:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                provider.crematoriumSearchList[provider.selectedCrematorium]['timing']['opening_time'] +
                                    '-' +
                                    provider.crematoriumSearchList[provider.selectedCrematorium]['timing']['closing_time'],
                                style: normalTextStyle()),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Contact No:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(provider.crematoriumSearchList[provider.selectedCrematorium]['crematoriumContact'],
                                style: normalTextStyle()),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Crematorium Capacity:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(provider.crematoriumSearchList[provider.selectedCrematorium]['capacity'].toString(),
                                style: normalTextStyle()),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Status:',
                              style: lightBlackTextStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(provider.crematoriumSearchList[provider.selectedCrematorium]['status'],
                                style: normalTextStyle()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForCremation(provider)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [redOrangeColor(), redOrangeColor(), orangeColor()]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'APPLY',
                        style: whiteTextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
