import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config/error_model.dart';
import '../../config/result_class.dart';
import '../models/patient_model.dart';
import '../models/report_model.dart';

class StaffDataSource {
  Future<ResponseState<List<Patient>>> fetchPatients() async {
    try {
      List<Patient> patients = [];
      await FirebaseFirestore.instance
          .collection('users')
          .where('accountType', isEqualTo: 'patient')
          .get()
          .then((value) {
        for (var element in value.docs) {
          patients.add(Patient.fromMap(element.data()));
        }
      });
      return ResponseState.success(patients);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> changeHealthStatus(
      {required patientId, required newHealthStatus}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(patientId)
          .update({
        'healthStatus': newHealthStatus,
      });
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<List<Report>>> fetchReports() async {
    try {
      List<Report> reports = [];
      await FirebaseFirestore.instance
          .collection('reports')
          .get()
          .then((value) {
        for (var element in value.docs) {
          reports.add(Report.fromMap(element.data()));
        }
      });
      return ResponseState.success(reports);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> deleteReport({required reportId}) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('reports').doc(reportId);
      await docRef.delete();
      return ResponseState.success(true);
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
