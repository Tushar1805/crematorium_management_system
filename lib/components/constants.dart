import 'package:flutter/material.dart';

Color orangeColor() {
  return Color(0XFFfb902d);
}

Color redOrangeColor() {
  return Color(0XFFeb8345);
}

Color lightBlack() {
  return Color(0XFF555555);
}

Color gray() {
  return Color(0XFF999999);
}

Color lightGray() {
  return Color(0XFFd9d9d9);
}

TextStyle lightBlackTextStyle() {
  return TextStyle(
      fontFamily: 'Source Sans Pro',
      fontSize: 15,
      color: lightBlack(),
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600);
}

TextStyle normalTextStyle() {
  return TextStyle(
      fontFamily: 'Source Sans Pro',
      fontSize: 15,
      color: lightBlack(),
      fontWeight: FontWeight.w300);
}

TextStyle whiteTextStyle() {
  return TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0);
}

BoxDecoration bottomBorder() {
  return BoxDecoration(
      border: Border(
    bottom: BorderSide(width: 3.0, color: orangeColor()),
  ));
}

BoxDecoration topBottomGradient() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [orangeColor(), redOrangeColor()]),
  );
}

InputDecoration loginInputDecoration() {
  return InputDecoration(
    hintText: 'Mobile Number',
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
      borderSide: BorderSide(color: lightGray(), width: 1),
    ),
  );
}
