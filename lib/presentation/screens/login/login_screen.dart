import 'package:flutter/material.dart';

import '../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginScreenTopImage(),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 10,
                    child: LoginForm(),
                  ),
                  Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
