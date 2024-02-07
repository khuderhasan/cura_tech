import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/auth_cubit/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  Future<void> _resetpassword(BuildContext context) async {
    if (_emailController.text.isNotEmpty) {
      await context
          .read<AuthCubit>()
          .resetPassword(email: _emailController.text.trim());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Rest'),
        centerTitle: true,
      ),
      body: BlocListener<AuthCubit, RegisterState>(
        listener: (context, state) {
          if (state is EmptyRegisterState) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      content:
                          Text('Password reset link sent! Check your email'),
                    ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  'Please Enter your Email and We will send you a password reset link',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Your email",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              MaterialButton(
                onPressed: () {
                  _resetpassword(context);
                },
                textColor: Colors.deepPurple,
                child: const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
