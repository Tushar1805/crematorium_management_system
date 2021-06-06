import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/Admin/loading.dart';
import 'package:way_to_heaven/Admin/requestInfo.dart';
import 'package:way_to_heaven/Admin/showProofOfDeath.dart';
import 'package:way_to_heaven/components/constants.dart';

class RequestPage extends StatefulWidget {
  AdminProvider provider;
  RequestPage(@required this.provider);
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    Widget Selector(BuildContext context, provider) {
      switch (provider.state) {
        // Changes to be made
        case States.loading:
          return loading();
          break;
        case States.requestInfo:
          return requestInfo(provider, context);
          break;
        case States.showProofOfDeath:
          return viewProofOfDeath(provider, context);
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
        body: Selector(context, provider));
  }
}
