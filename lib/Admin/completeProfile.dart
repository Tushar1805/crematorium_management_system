import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/components/constants.dart';

class CompleteAdminProfile extends StatefulWidget {
  @override
  _CompleteAdminProfileState createState() => _CompleteAdminProfileState();
}

class _CompleteAdminProfileState extends State<CompleteAdminProfile> {
  String name, email, address, phone, age, role, crematoriumName, capacity;
  TimeOfDay from;
  TimeOfDay till;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final User user = auth.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then(
      (value) {
        setState(() {
          role = (value["role"].toString());
          print(role);
        });
      },
    );
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
        },
        onSaved: (String value) {
          phone = value;
        });
  }

  Widget _buildAddress() {
    return TextFormField(
        decoration: formInputDecoration("Enter Address of Crematorium"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Address is Required';
          }
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
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildName(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildEmail(),
                    SizedBox(
                      height: 15,
                    ),
                    // _buildPhone(),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    _buildAddress(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildAge(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildCrematoriumName(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildCrematoriumCapacity(),
                    SizedBox(
                      height: 15,
                    ),
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
                        print(name);
                        print(email);
                        print(address);
                        print(phone);
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
    );
  }
}
