import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

Widget LoginPage(BuildContext context, LoginProvider provider) {
  void _showSnackBar() {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 30.0,
        child: Center(
          child: Text(
            'Enter a valid mobile number',
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

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "GET STARTED",
                style: lightBlackTextStyle(),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3.0, color: orangeColor()),
                ),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Enter your mobile number",
              textAlign: TextAlign.start,
              style: normalTextStyle(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: true,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 10,
            onChanged: (val) => provider.number = val.toString(),
            decoration: loginInputDecoration(),
            style: TextStyle(color: lightBlack()),
            cursorColor: lightBlack(),
            cursorWidth: 1.0,
          ),
          SizedBox(height: 20.0),
          FlatButton(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "CONTINUE",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            minWidth: MediaQuery.of(context).size.width - 40,
            color: orangeColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            onPressed: () {
              if (provider.number == null) {
                provider.changeStatus(States.otpVerification);
                _showSnackBar();
              } else if (provider.number.length < 10) {
                _showSnackBar();
              } else if (provider.number.length == 10) {
                provider.numberEntered();
              } else {
                _showSnackBar();
              }
            },
          ),
        ],
      ),
    ),
  );
}
