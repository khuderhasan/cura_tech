import 'package:flutter/material.dart';

import '../components/background.dart';
import 'components/signup_form.dart';
import 'components/signup_screen_image.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
        child: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignUpScreenTopImage(),
          Row(
            children: [
              Spacer(),
              Expanded(flex: 8, child: SignUpForm()),
              Spacer()
            ],
          )
        ],
      )),
    ));
  }
}
