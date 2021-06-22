import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/User/Profile/userProfile.dart';
import 'package:way_to_heaven/User/userProvider.dart';

class UserProfileBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ], child: UserProfile());
  }
}
