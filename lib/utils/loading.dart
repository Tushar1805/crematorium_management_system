import 'package:flutter/material.dart';
import 'package:way_to_heaven/components/constants.dart';

class Loading extends StatelessWidget {
  final text;
  Loading(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: CircularProgressIndicator(
        backgroundColor: orangeColor(),
      ),
    ));
  }
}
