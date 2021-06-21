import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Admin/Profile/adminProfile.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';

class AdminProfileBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
    ], child: AdminProfile());
  }
}
