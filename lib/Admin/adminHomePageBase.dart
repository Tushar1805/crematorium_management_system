import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Admin/adminHome.dart';
import 'package:way_to_heaven/Admin/adminProvider.dart';

class AdminHomePageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminProvider() ,
      child: AdminHomePage(),
    );
  }
}