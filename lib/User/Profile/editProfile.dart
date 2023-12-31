import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/Authentication/verifyOTP.dart';
import 'package:way_to_heaven/components/constants.dart';

class EditProfile extends StatefulWidget {
  LoginProvider provider;
  EditProfile(this.provider);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name, email, address, phone, age, gender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(text) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 30.0,
        child: Center(
          child: Text(
            '$text',
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

  Widget _buildPhone() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 10,
      decoration: InputDecoration(
          hintText: "Enter Mobile Number",
          contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
          focusColor: lightBlack(),
          hintStyle: normalTextStyle().copyWith(fontSize: 14, color: gray()),
          counterText: "",
          filled: true,
          fillColor: Colors.white54,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            borderSide: BorderSide(color: lightGray(), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            borderSide: BorderSide(
              color: lightGray(),
              width: 1,
            ),
          ),
          suffixIcon: TextButton(
            onPressed: () {
              // OTP verification code is to be added here
              if (widget.provider.number == null) {
                widget.provider.changeStatus(States.otpVerification);
                _showSnackBar("Enter a Valid Mobile Number");
              } else if (widget.provider.number.length < 10) {
                _showSnackBar("Enter a valid Mobile Number");
              } else if (widget.provider.number.length == 10) {
                widget.provider.numberEntered();
                // VerifyOTP(context, widget.provider);
              } else {
                _showSnackBar("Enter a valid Mobile Number");
              }
            },
            child: Text("Verify"),
            onLongPress: () {
              _showSnackBar("Verify your Mobile Number");
            },
          )),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        }
        return null;
      },
      onSaved: (String value) {
        phone = value;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
        decoration: formInputDecoration("Enter Residential Address"),
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
          }
          return null;
        },
        onSaved: (String value) {
          age = value;
        });
  }

  Widget _buildGender() {
    return TextFormField(
        decoration: formInputDecoration("Enter Gender"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Gender is Required';
          }
          return null;
        },
        onSaved: (String value) {
          gender = value;
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
                Text('Edit Profile', style: titleBarWhiteTextStyle()),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildName(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildEmail(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildPhone(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildAddress(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildAge(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildGender(),
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
