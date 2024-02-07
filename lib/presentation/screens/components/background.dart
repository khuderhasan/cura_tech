import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_top.png',
                width: 120,
              ),
            ),
            Positioned(
              child: SafeArea(child: child),
            ),
          ],
        ),
      ),
    );
  }
}
