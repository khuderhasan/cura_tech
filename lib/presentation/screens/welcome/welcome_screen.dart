import 'package:flutter/material.dart';

import 'package:location/location.dart';

import '../../../services/location_helper.dart';
import '../components/background.dart';
import 'components/login_signup_buttons.dart';
import 'components/welcome_image.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  LocationData? _locationData;
  Future<void> _getLocation() async {
    _locationData = await LocationHelper.getLocationPermisions();
    if (_locationData != null) {
      await LocationHelper.saveCurrentLocation(
          longitude: _locationData!.longitude,
          latitude: _locationData!.latitude);
    } else {
      // Handle location retrieval failure (e.g., display an error message)
      debugPrint('Failed to get location');
      // You might consider showing an error message or retrying
    }
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Background(
        child: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WelcomeImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 6,
                // The Buttons should be in here
                child: LoginAndSignupBtn(),
              ),
              Spacer(),
            ],
          )
        ],
      )),
    ));
  }
}
