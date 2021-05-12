import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  final text;
  SomethingWentWrong(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text("Something went wrong..."),
    ));
  }
}
