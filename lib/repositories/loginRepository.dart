import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  String uid;
  final ref = FirebaseFirestore.instance.collection('Users').doc();
  FirebaseAuth auth = FirebaseAuth.instance;

  String getUid() {
    return ref.id.toString();
  }

  Future<String> getUserUid() async {
    User user = auth.currentUser;

    return user.uid.toString();
  }
}
