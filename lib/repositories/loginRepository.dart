import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final ref = FirebaseFirestore.instance.collection('Users');

  String getUid() {
    return   '';
  }
}
