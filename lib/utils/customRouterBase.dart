import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_heaven/Authentication/loginProvider.dart';
import 'package:way_to_heaven/utils/customRouter.dart';

class CustomRouterBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      StreamProvider<User>(
          create: (_) => LoginProvider().getUsers(), initialData: null)
    ], child: CustomRouter());
  }
}
