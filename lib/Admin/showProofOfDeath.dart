import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class ViewProofOfDeath extends StatefulWidget {
  AdminProvider provider;
  ViewProofOfDeath(@required this.provider);
  @override
  _ViewProofOfDeathState createState() => _ViewProofOfDeathState();
}

class _ViewProofOfDeathState extends State<ViewProofOfDeath> {
  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    print(widget.provider.imageUrl);
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
                Text('Proof Of Death', style: titleBarWhiteTextStyle()),
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
          child: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.white),
              loadingChild: Image.asset('assets/icons/image_placeholder.png'),
              imageProvider: NetworkImage(provider.imageUrl),
            )),
      )),
    );
  }
}
