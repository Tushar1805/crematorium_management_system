import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:way_to_heaven/components/constants.dart';

Widget loading() {
  return Container(
    color: Colors.white,
    child: Center(
      child: SpinKitThreeBounce(
        color: redOrangeColor(),
        size: 40.0,
      ),
    ),
  );
}
