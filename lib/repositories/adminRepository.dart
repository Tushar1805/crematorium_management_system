import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRepository {
  String adminId = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore ref = FirebaseFirestore.instance;
//
//
//
//
//
//
//
//
//
  Future<List<Map>> fetchRequestList() async {
    List<Map> list = [];
    await ref
        .collection('Applications')
        .orderBy('application_time', descending: true)
        .where('crematoriumId', isEqualTo: adminId)
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

  Future<List<Map>> fetchCurrentList() async {
    List<Map> list = [];
    await ref
        .collection('Applications')
        .where('crematoriumId', isEqualTo: adminId)
        .get()
        .then((value) => value.docs.forEach((element) {
              Map map = {};
              map = element.data();
              list.add(map);
            }));
    return list;
  }

  Future<List<Map>> fetchUpcomingList() async {
    Map map = {};
    await ref
        .collection('Applications')
        .where('crematoriumId', isEqualTo: adminId)
        .get()
        .then((value) => value.docs.forEach((element) {
              map = element.data();
            }));
  }

  Future<void> rejectApplication(selectedRequestId, reasonForRejection) async {
    await ref
        .collection('Applications')
        .doc(selectedRequestId)
        .update({'application_status': 'rejected', 'reason_for_rejection': reasonForRejection});
    print('rejected');
  }
}
