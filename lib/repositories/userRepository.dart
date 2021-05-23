import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserRepository{
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  Future<List<Map>> getCrematoriums() async {
    List<Map<dynamic , dynamic>> mapList = [] ;
     await ref.where('role', isEqualTo : 'Admin').get().then((value){
       value.docs.forEach((element) {
         Map map = {};
         map = element.data();
         mapList.add(map);
          print(element.data());
       });
     });
    //  print(mapList);
     return mapList ;    
  }
}