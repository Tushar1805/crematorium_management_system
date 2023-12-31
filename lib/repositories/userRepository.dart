import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserRepository {
  FirebaseFirestore ref = FirebaseFirestore.instance;

  Future<List<Map>> getCrematoriums() async {
    List<Map<dynamic, dynamic>> mapList = [];
    await ref
        .collection('Users')
        .where('role', isEqualTo: 'Admin')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Map map = {};
        map = element.data();
        map['crematoriumId'] = element.id;
        mapList.add(map);
        print(element.data());
      });
    });
    //  print(mapList);
    return mapList;
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    Map<String, dynamic> map = {};
    String uid = FirebaseAuth.instance.currentUser.uid;
    await ref.collection('Users').doc(uid).get().then((value) {
      map = value.data();
      print(value.data());
    });
    //  print(mapList);
    return map;
  }

  Future<void> submitApplication(
      String applicant_name,
      String dead_persons_name,
      String dead_persons_age,
      String selectedGender,
      String cause_of_death,
      Map crematoriumMap,
      String imageUrl) async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    Map<String, dynamic> map = {};
    map['userId'] = uid;
    map['applicant_name'] = applicant_name;
    map['dead_persons_name'] = dead_persons_name;
    map['dead_persons_age'] = dead_persons_age;
    map['selectedGender'] = selectedGender;
    map['cause_of_death'] = cause_of_death;
    map['application_time'] = FieldValue.serverTimestamp();
    map['crematoriumId'] = crematoriumMap['crematoriumId'];
    map['crematoriumName'] = crematoriumMap['crematoriumName'];
    map['imageUrl'] = imageUrl;
    map['application_status'] = 'Under Review';

    await ref.collection('Applications').add(map);
  }

  Future<List<Map>> fetchApplicationList() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    List<Map> list = [];
    await ref
        .collection('Applications')
        .orderBy('application_time', descending: true)
        .where('userId', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              Map map = {};
              map = element.data();
              map['requestId'] = element.id;
              list.add(map);
            }));
    print(list);
    return list;
  }
}
