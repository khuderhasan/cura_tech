import 'dart:convert';

import 'patients_main/patient_home_screen.dart';
import 'staff_main/staff_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  String? usertype;
  @override
  void initState() {
    getUserType();
    super.initState();
  }

  Future<void> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUserType =
        await json.decode(prefs.getString('userInfo')!) as Map<String, dynamic>;
    usertype = savedUserType['accountType'];
  }

  @override
  Widget build(BuildContext context) {
    return (usertype == 'staff')
        ? const StaffHomeScreen()
        : const PatientHomeScreen();
  }
}
