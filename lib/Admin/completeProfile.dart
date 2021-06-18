import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Admin/admin.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class CompleteAdminProfile extends StatefulWidget {
  @override
  _CompleteAdminProfileState createState() => _CompleteAdminProfileState();
}

class _CompleteAdminProfileState extends State<CompleteAdminProfile> {
  String name,
      email,
      address,
      contact,
      age,
      role,
      crematoriumName,
      crematoriumContact,
      capacity,
      cremationTime,
      uid;
  TimeOfDay from, till;
  TimeOfDay time1;
  TimeOfDay time2;
  TimeOfDay picked1;
  TimeOfDay picked2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    time1 = TimeOfDay.now();
    time2 = TimeOfDay.now();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final User user = auth.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then(
      (value) {
        setState(() {
          role = (value["role"].toString());
          uid = user.uid;
          print(role);
        });
      },
    );
  }

  Future<Null> selectTime1(BuildContext context) async {
    picked1 = await showTimePicker(context: context, initialTime: time1);

    if (picked1 != null) {
      setState(() {
        time1 = picked1;
        from = time1;
      });
    }
  }

  Future<Null> selectTime2(BuildContext context) async {
    picked2 = await showTimePicker(context: context, initialTime: time2);

    if (picked2 != null) {
      setState(() {
        time2 = picked2;
        till = time2;
      });
    }
  }

  Widget _buildName() {
    return TextFormField(
        decoration: formInputDecoration("Enter Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          name = value;
        });
  }

  Widget _buildEmail() {
    return TextFormField(
        decoration: formInputDecoration("Enter Email Address"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is Required';
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
              .hasMatch(value)) {
            return 'Please Enter a valid Email Address';
          }
          return null;
        },
        onSaved: (String value) {
          email = value;
        });
  }

  Widget _buildCoontact() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        decoration: formInputDecoration("Enter Contact Number"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Contact Number is Required';
          }
          return null;
        },
        onSaved: (String value) {
          contact = value;
        });
  }

  Widget _buildAddress() {
    return TextFormField(
        decoration: formInputDecoration("Enter Address of Crematorium"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Address is Required';
          }
          return null;
        },
        onSaved: (String value) {
          address = value;
        });
  }

  Widget _buildAge() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: formInputDecoration("Enter Age"),
        validator: (String value) {
          int age = int.tryParse(value);
          if (age == null || age <= 0) {
            return 'Age is Required';
          } else if (age > 105) {
            return 'Invalid Age';
          }
          return null;
        },
        onSaved: (String value) {
          age = value;
        });
  }

  Widget _buildCrematoriumName() {
    return TextFormField(
        decoration: formInputDecoration("Enter Crematorium Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Crematorium Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          crematoriumName = value;
        });
  }

  Widget _buildCrematoriumContact() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        decoration: formInputDecoration("Enter Crematorium Contact Number"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Contact Number is Required';
          }
          return null;
        },
        onSaved: (String value) {
          crematoriumContact = value;
        });
  }

  Widget _buildCrematoriumCapacity() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: formInputDecoration("Enter Capacity of Crematorium"),
        validator: (String value) {
          int capacity = int.tryParse(value);
          if (capacity == null || capacity <= 0) {
            return 'Capacity is Required';
          }
          return null;
        },
        onSaved: (String value) {
          capacity = value;
        });
  }

  Widget _buildCremationTime() {
    return Container(
      child: DropdownButtonFormField<String>(
        decoration:
            formInputDecoration("Select Time for one Cremation in hour"),
        items: <String>[
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '10',
          '11',
          '12'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: new Text(value + " Hr"),
            onTap: () {
              cremationTime = value;
              print(cremationTime);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }

  Widget _buildTiming() {
    return Container(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .41,
            child: Row(
              children: [
                Text(
                  'From:',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: lightGray(),
                        width: 1,
                      )),
                  child: Row(children: [
                    Container(
                      // color: Colors.red,
                      width: 35,
                      child: IconButton(
                        icon: Icon(Icons.alarm),
                        onPressed: () {
                          selectTime1(context);
                        },
                        color: gray(),
                      ),
                    ),
                    Text(
                      '${time1.hour}:${time1.minute}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Row(
              children: [
                Text(
                  'Till:',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: lightGray(),
                        width: 1,
                      )),
                  child: Row(children: [
                    Container(
                        // color: Colors.red,
                        width: 35,
                        child: IconButton(
                          icon: Icon(Icons.alarm),
                          onPressed: () {
                            selectTime2(context);
                            print(time2);
                          },
                          color: gray(),
                        )),
                    Text(
                      '${time2.hour}:${time2.minute}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(string) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      alignment: Alignment.centerLeft,
      child: Text(
        "$string :",
        style: lightBlackTextStyle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBar(context, value) {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Container(
          height: 20.0,
          child: Center(
            child: Text(
              '$value',
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: lightBlack(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    void addCompleteProfile() {
      final isValid = _formKey.currentState.validate();
      if (!isValid) {
        return;
      } else {
        final user = AdminClass(
          name: name,
          createdTime: DateTime.now(),
          email: email,
          address: address,
          age: age,
          contact: contact,
          role: role,
          crematoriumName: crematoriumName,
          crematoriumContact: crematoriumContact,
          capacity: capacity,
          cremationTime: cremationTime,
        );

        final provider = Provider.of<AdminProvider>(context, listen: false);
        provider.completeAdminProfile(user, uid);
        Navigator.of(context).pop();
      }
    }

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
                Text('Complete Profile', style: titleBarWhiteTextStyle()),
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
        margin: EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTitle("Name"),
                      _buildName(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Email"),
                      _buildEmail(),
                      SizedBox(
                        height: 15,
                      ),
                      // _buildPhone(),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      _buildTitle("Address"),
                      _buildAddress(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Age"),
                      _buildAge(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Crematorium Name"),
                      _buildCrematoriumName(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Crematorium Contact"),
                      _buildCrematoriumContact(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Capacity"),
                      _buildCrematoriumCapacity(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Average Time of cremation"),
                      _buildCremationTime(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTitle("Timing"),
                      _buildTiming(),
                      SizedBox(
                        height: 60,
                      ),
                      RaisedButton(
                        color: redOrangeColor(),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          addCompleteProfile();
                          print(name);
                          print(email);
                          print(address);
                          print(contact);
                          print(age);
                          showSnackBar(context, "Profile Updated Successfully");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "Submit",
                              style: whiteTextStyle(),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            )),
      ),
    );
  }
}
