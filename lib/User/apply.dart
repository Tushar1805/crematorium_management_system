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
    TextEditingController applicant_name = TextEditingController();
    applicant_name.text = provider.applicant_name;
    TextEditingController dead_persons_name = TextEditingController();
    dead_persons_name.text = provider.dead_persons_name;
    TextEditingController age = TextEditingController();
    age.text = provider.dead_persons_age;
    TextEditingController cause_of_death = TextEditingController();
    cause_of_death.text = provider.cause_of_death;

    Future<void> selectImage(String source) async {
      if (provider.image = null) {
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

    void showSubmitDialog(bool isSuccess) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                isSuccess ? 'Success' : 'Warning',
                style: lightBlackTextStyle().copyWith(fontSize: 18),
              )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        isSuccess
                            ? 'Application Submited Successfully!'
                            : 'All Fields Are Necesary!',
                        style: normalTextStyle()
                            .copyWith(color: redOrangeColor())),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {
                      if (isSuccess) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

    void uploadProofOfDeathClicked(context) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                'Select Image From',
                style: darkBlackTextStyle()
                    .copyWith(fontSize: 18.0, fontWeight: FontWeight.w600),
              )),
              actions: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Card(
                          elevation: 0.0,
                          color: Color(0xFFf0f0fa),
                          child: InkWell(
                            onTap: () async {
                              await selectImage('camera');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 8.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: redOrangeColor(),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text('Use Camera')
                                ],
                              ),
                            ),
                          )),
                      Card(
                          elevation: 0.0,
                          color: Color(0xFFf0f0fa),
                          child: InkWell(
                            onTap: () async {
                              await selectImage('gallery');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.photo_library_outlined,
                                    color: redOrangeColor(),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text('Upload from Gallery')
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            );
          });
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
                  MediaQuery.of(context).padding.top -
                  60,
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
                              readOnly: true,
                              controller: applicant_name,
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
                              controller: dead_persons_name,
                              decoration: loginInputDecoration().copyWith(
                                  hintText: 'Dead Person\'sColumn Name'),
                              maxLength: 50,
                              onChanged: (value) {
                                provider.dead_persons_name = value;
                              },
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
                              autocorrect: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: loginInputDecoration()
                                  .copyWith(hintText: 'Age'),
                              maxLength: 3,
                              onChanged: (value) {
                                provider.dead_persons_age = value;
                              },
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
                            Row(
                              children: [
                                Radio(
                                    value: 'Male',
                                    activeColor: orangeColor(),
                                    groupValue: provider.selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectGenderClicked(value);
                                      });
                                    }),
                                Text('Male'),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Radio(
                                    value: 'Female',
                                    activeColor: orangeColor(),
                                    groupValue: provider.selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectGenderClicked(value);
                                      });
                                    }),
                                Text('Female'),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
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
                              maxLength: 50,
                              onChanged: (value) {
                                provider.cause_of_death = value;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            InkWell(
                              onTap: () {
                                uploadProofOfDeathClicked(context);
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
                                        'Upload Proof Of Death',
                                        style: whiteTextStyle()
                                            .copyWith(fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        if (provider.submitApplicationToCrematorium()) {
                          showSubmitDialog(true);
                        } else {
                          showSubmitDialog(false);
                        }
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
