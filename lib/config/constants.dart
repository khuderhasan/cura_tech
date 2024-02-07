import 'package:flutter/material.dart';

const double defaultPadding = 16.0;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const errorColor = Color.fromARGB(255, 190, 18, 5);
const kPrimaryColor = Color.fromARGB(255, 167, 120, 211);
const kPrimaryLightColor = Color(0xFFF1E6FF);
final appTheme = ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        shape: const StadiumBorder(),
        maximumSize: const Size(double.infinity, 56),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryLightColor,
      iconColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ));

List<DropdownMenuItem<String>> genderDropdownItems = const [
  DropdownMenuItem(
    value: 'male',
    child: Text('Male'),
  ),
  DropdownMenuItem(
    value: 'female',
    child: Text('Female'),
  ),
];
List<DropdownMenuItem<String>> accountTypeDropdownItems = const [
  DropdownMenuItem(
    value: 'staff',
    child: Text('Medical Staff'),
  ),
  DropdownMenuItem(
    value: 'patient',
    child: Text('Patient'),
  ),
];
