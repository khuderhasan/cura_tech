import 'package:cloud_firestore/cloud_firestore.dart';

class TestFire {
  final fireStore = FirebaseFirestore.instance;

  static Future<void> storeParent() async {
    List<Map<String, dynamic>> children = [
      {'id': 'child1', 'school': 'school1', 'buss': 'buss1'},
      {'id': 'child2', 'school': 'school2', 'buss': 'buss2'}
    ];
    await FirebaseFirestore.instance.collection('users1').doc('parentId').set({
      'email': 'email',
      'password': 'password',
    });
    for (var child in children) {
      await FirebaseFirestore.instance
          .collection('users1')
          .doc('parentId')
          .collection('children')
          .add(child);
    }
  }

  static Future<void> getChildrenBusses() async {
    FirebaseFirestore.instance
        .collection('users1')
        .doc('parentId')
        .collection('children')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element['buss']);
      });
    });
  }
}
