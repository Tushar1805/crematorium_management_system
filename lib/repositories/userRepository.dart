import 'package:cloud_firestore/cloud_firestore.dart';
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
        mapList.add(map);
        print(element.data());
      });
    });
    //  print(mapList);
    return mapList;
  }

  Future<void> submitApplication(
      String applicant_name,
      String dead_persons_name,
      String dead_persons_age,
      String selectedGender,
      String cause_of_death) async {
    Map<dynamic, dynamic> map = {};
    map['applicant_name'] = applicant_name;
    map['dead_persons_name'] = dead_persons_name;
    map['dead_persons_age'] = dead_persons_age;
    map['selectedGender'] = selectedGender;
    map['cause_of_death'] = cause_of_death;

    await ref.collection('Applications').add(map);
  }
}
