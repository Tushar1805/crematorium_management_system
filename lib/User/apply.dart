import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:way_to_heaven/User/userProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class ApplyForCremation extends StatefulWidget {
  UserProvider provider;
  ApplyForCremation(@required this.provider);
  @override
  _ApplyForCremationState createState() => _ApplyForCremationState();
}

class _ApplyForCremationState extends State<ApplyForCremation> {
  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    Future<void> selectImage(String source) async {
      if (provider.image.length < 2) {
        if (source == 'camera') {
          final pickedImage =
              await ImagePicker().getImage(source: ImageSource.camera);
          if (pickedImage != null) {
            provider.addImage(pickedImage.path);
          } else {
            final snackBar = SnackBar(content: Text('Image Not Selected!'));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          final pickedImage =
              await ImagePicker().getImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            provider.addImage(pickedImage.path);
          } else {
            final snackBar = SnackBar(content: Text('Image Not Selected!'));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      } else {
        final snackBar =
            SnackBar(content: Text('Only 2 Images Can be Uploaded!'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      print(provider.image.length);
    }

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
                  Text('Application', style: titleBarWhiteTextStyle()),
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top +
                  10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(' Applicant Name',
                                style: lightBlackTextStyle()
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              decoration: loginInputDecoration()
                                  .copyWith(hintText: 'Applicant Name'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(' Dead Person\'s Name',
                                style: lightBlackTextStyle()
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              decoration: loginInputDecoration()
                                  .copyWith(hintText: 'Applicant Name'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(' Age',
                                style: lightBlackTextStyle()
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              decoration: loginInputDecoration()
                                  .copyWith(hintText: 'Age'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(' Gender',
                                style: lightBlackTextStyle()
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              decoration: loginInputDecoration()
                                  .copyWith(hintText: 'Gender'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(' Cause Of Death',
                                style: lightBlackTextStyle()
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              decoration: loginInputDecoration()
                                  .copyWith(hintText: 'Cause Of Death'),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            InkWell(
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
                                        'Upload Proof Of Death',
                                        style: whiteTextStyle()
                                            .copyWith(fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
                                    await selectImage('camera');
                                  },
                                  icon: Icon(Icons.add_a_photo_outlined),
                                  label: Text('Use Camera'),
                                ),
                                TextButton.icon(
                                    onPressed: () async {
                                      await selectImage('gallery');
                                    },
                                    icon: Icon(Icons.photo_library_outlined),
                                    label: Text('Upload from Gallery')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
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
                            'SUBMIT',
                            style: whiteTextStyle().copyWith(
                                fontSize: 15.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
