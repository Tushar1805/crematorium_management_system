import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final ref = FirebaseFirestore.instance.collection('Users');
  String uid = FirebaseAuth.instance.currentUser.uid;

  String getUid() {
    return uid;
  }
}
