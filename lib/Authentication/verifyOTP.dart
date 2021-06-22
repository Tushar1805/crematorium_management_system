import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:way_to_heaven/Admin/adminHome.dart';
import 'package:way_to_heaven/Admin/adminHomePageBase.dart';
import 'package:way_to_heaven/Admin/completeProfile.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/Authentication/setRole.dart';
import 'package:way_to_heaven/User/completeProfile.dart';
import 'package:way_to_heaven/User/userHome.dart';
import 'package:way_to_heaven/User/userHomePageBase.dart';
import 'package:way_to_heaven/components/constants.dart';

Widget VerifyOTP(BuildContext context, LoginProvider provider) {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  String actualCode;

  void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 30.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 14.0, color: Colors.white),
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

  _verify() async {
    FirebaseAuth firebaseAuth = await FirebaseAuth.instance;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      actualCode = verificationId;

      print('Code sent to ${provider.number}');
      provider.status = "\nEnter the code sent to " + provider.number;
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      actualCode = verificationId;

      provider.status = "\nAuto retrieval time out";
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      provider.status = '${authException.message}';

      print("Error message: " + provider.status);
      if (authException.message.contains('not authorized'))
        provider.status = 'Something has gone wrong, please try later';
      else if (authException.message.contains('Network'))
        provider.status = 'Please check your internet connection and try again';
      else
        provider.status = 'Something has gone wrong, please try later';
    };

    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential auth) {
      provider.status = 'Auto retrieving verification code';

      PhoneAuthCredential _authCredential = auth;

      firebaseAuth
          .signInWithCredential(_authCredential)
          .then((UserCredential value) async {
        print(value);
        if (value.user != null) {
          provider.status = 'Authentication successful';

          String role;
          bool profileExist = false;
          bool isProfileCompleted = true;
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(value.user.uid)
              .get()
              .then((value) {
            if (value.data() == null) {
              profileExist = false;
            } else {
              role = value.data()['role'];
            }
          });
          if (role == 'Admin') {
            if (isProfileCompleted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminHomePageBase()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteAdminProfile()));
            }
          } else if (role == 'User') {
            if (isProfileCompleted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserHomePageBase()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteUserProfile()));
            }
          } else if (profileExist == false) {
            FirebaseFirestore.instance
                .collection('Users')
                .doc(value.user.uid)
                .set({
              'uid': value.user.uid,
              'mobile': provider.number,
              'role': ''
            });
            print('Login successful...');
            provider.otpVerified();
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => SetRole()));
          } else {
            provider.state = States.loginScreen;
          }

          // onAuthenticationSuccessful();
        } else {
          print('Invalid code/invalid authentication');
          provider.status = 'Invalid code/invalid authentication';
        }
      }).catchError((error) {
        print(error.toString());
        print('Something has gone wrong, please try later');
        provider.status = 'Something has gone wrong, please try later';
      });
    };

    firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91' + provider.number,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Widget justRoundedCornersPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white54,
      borderRadius: BorderRadius.circular(2.0),
      border: Border.all(
        color: lightGray(),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: PinPut(
        fieldsCount: 6,
        withCursor: true,
        textStyle: lightBlackTextStyle(),
        eachFieldWidth: 42.0,
        eachFieldHeight: 42.0,
        onSubmit: (pin) async {
          try {
            await FirebaseAuth.instance
                .signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: actualCode, smsCode: pin))
                .then((value) async {
              if (value.user != null) {
                print('pass to home');
              }
            });
          } catch (e) {
            print(actualCode);
            print('on submit failed...');
          }
        },
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
      ),
    );
  }

  _verify();

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "ENTER OTP",
                  style: lightBlackTextStyle(),
                ),
                decoration: bottomBorder(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                children: [
                  Text(
                    "We have sent a one time verification code to your registered mobile ${provider.number}",
                    textAlign: TextAlign.center,
                    style: normalTextStyle(),
                  ),
                  Text(
                    "Make sure that your entered mobile number is in your smartphone.",
                    textAlign: TextAlign.center,
                    style: normalTextStyle().copyWith(color: Color(0xFFef5350)),
                  )
                ],
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              child: Text("Change Number",
                  style: TextStyle(
                      color: orangeColor(),
                      fontSize: 14,
                      fontWeight: FontWeight.w800)),
              minWidth: MediaQuery.of(context).size.width / 2 - 30,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              onPressed: () {
                provider.changeStatus(States.loginScreen);
              },
            ),
            SizedBox(
              height: 20,
            ),
            justRoundedCornersPinPut(),
            SizedBox(height: 20.0),
            // Container(
            //   alignment: Alignment.center,
            //   child: FlatButton(
            //     padding: EdgeInsets.all(15.0),
            //     child: Text(
            //       "VERIFY OTP",
            //       style: TextStyle(color: Colors.white, fontSize: 14),
            //     ),
            //     minWidth: MediaQuery.of(context).size.width - 98,
            //     color: orangeColor(),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(3.0),
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
            SizedBox(height: 20.0),
            Text(
              provider.status,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            Spacer(),
            Text(
              "Didn't get the OTP?",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF767676)),
            ),
            SizedBox(height: 20.0),
            FlatButton(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "RESEND OTP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
              ),
              minWidth: MediaQuery.of(context).size.width / 2 - 70,
              color: orangeColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    ),
  );
}

// OTP verification code
