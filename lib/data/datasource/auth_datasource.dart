import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/location_helper.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/error_model.dart';
import '../../config/result_class.dart';

class AuthDataSource {
  Future<ResponseState<UserModel>> signUp({
    required fullName,
    required email,
    required password,
    required gender,
    required accountType,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (accountType == 'patient') {
        final locationData = await LocationHelper.getSavedCurrentLocation();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'id': userCredential.user!.uid,
          'fullName': fullName,
          'email': email,
          'gender': gender,
          'accountType': accountType,
          'healthStatus': 'Healthy',
          'lat': locationData['latitude'],
          'long': locationData['longitude']
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'id': userCredential.user!.uid,
          'fullName': fullName,
          'email': email,
          'gender': gender,
          'accountType': accountType,
        });
      }
      final userData = UserModel(
          id: userCredential.user!.uid,
          fullName: fullName,
          email: email,
          accountType: accountType,
          gender: gender);
      await saveUserInfo(userData.accountType);
      return ResponseState.success(userData);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<UserModel>> signIn(
      {required email, required password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel? userData;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get()
          .then((value) {
        userData = UserModel.fromMap(value.data()!);
      });
      await saveUserInfo(userData!.accountType);
      return ResponseState.success(userData!);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      //should clear the shared prefrences in here
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> resetPassword({required email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }
}

Future<void> saveUserInfo(accountType) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('userInfo')) {
    await prefs.remove('userInfo');
  }
  final userInfo = json.encode({'accountType': accountType});
  prefs.setString('userInfo', userInfo);
}
