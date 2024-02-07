import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/location_helper.dart';
import '../models/patient_model.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config/error_model.dart';
import '../../config/result_class.dart';

class PatientDataSource {
  Future<ResponseState<bool>> sendReport({
    required content,
  }) async {
    try {
      final firebaseInstance = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;
      final userData =
          await firebaseInstance.collection('users').doc(user!.uid).get();
      await firebaseInstance.collection('reports').add({
        'userName': userData['fullName'],
        'userId': user.uid,
        'userEmail': userData['email'],
        'content': content,
        'createdAt': Timestamp.now(),
      }).then((docRef) => docRef.update({
            'id': docRef.id,
          }));

      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<List<Patient>>> fetchNeighborsPatients() async {
    final locationData = await LocationHelper.getSavedCurrentLocation();

    double userLat = locationData['latitude'];
    double userLon = locationData['longitude'];
    double radius = 200;

    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final List<Patient> neighborPatients = [];
      await FirebaseFirestore.instance
          .collection('users')
          .where('healthStatus', isEqualTo: 'Patient')
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (element.data()['lat'] == null) continue;
          if (element.data()['id'] == currentUserId) continue;
          double docLat = element.data()['lat'];
          double docLon = element.data()['long'];
          double distance = LocationHelper.calculateDistance(
              userLat, userLon, docLat, docLon);
          if (distance <= radius) {
            neighborPatients.add(Patient.fromMap(element.data()));
          }
        }
      });
      return ResponseState.success(neighborPatients);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<UserModel>> fetchProfileData() async {
    try {
      UserModel? currentUserData;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        currentUserData = UserModel.fromMap(value.data()!);
      });
      return ResponseState.success(currentUserData!);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }
}
