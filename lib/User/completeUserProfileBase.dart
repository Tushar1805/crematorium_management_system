import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/User/completeProfile.dart';
import 'package:way_to_heaven/User/userProvider.dart';

class CompleteUserProfileBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: CompleteUserProfile(),
    );
  }
}
