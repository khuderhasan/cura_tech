import '../../patients_main/patient_home_screen.dart';
import '../../staff_main/staff_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../../config/validators.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/auth_cubit/auth_state.dart';
import '../../components/all_ready_have_an_account_chech.dart';
import '../../signup/signup_screen.dart';
import '../reset_password_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  Future<void> _trySubmit(BuildContext context) async {
    FocusNode().unfocus();
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      await context
          .read<AuthCubit>()
          .signIn(email: _email.trim(), password: _password.trim());
    }
  }

  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          if (state.data.accountType == 'staff') {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const StaffHomeScreen();
              },
            ));
          } else if (state.data.accountType == 'patient') {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const PatientHomeScreen();
              },
            ));
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Text("Authenticated Successfully"),
              backgroundColor: Colors.green,
            ));
        } else if (state is ErrorRegisterState) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(color: errorColor),
              ),
              content: Text(
                state.error.message,
                style: const TextStyle(fontSize: defaultPadding),
              ),
            ),
          );
        }
      },
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //* Email TextField
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: emailValidator,
              onSaved: (value) {
                _email = value!;
              },
              decoration: InputDecoration(
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Your email",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            //* Password TextField
            Padding(
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding / 2),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: _hidePass,
                validator: passwordValidator,
                onSaved: (value) {
                  _password = value!;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
                  suffixIcon: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                        (_hidePass) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthCubit, RegisterState>(
              builder: (context, state) {
                if (state is ErrorRegisterState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: defaultPadding),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetPasswordScreen(),
                                ));
                          },
                          child: const Text(
                            'Forgot Your Passowrd ?',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: defaultPadding / 2),
            ElevatedButton(
              onPressed: () {
                _trySubmit(context);
              },
              child: BlocBuilder<AuthCubit, RegisterState>(
                bloc: context.read<AuthCubit>(),
                builder: (context, state) {
                  if (state is LoadingRegisterState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessRegisterState) {
                    return const Center(
                      child: Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      ),
                    );
                  }
                  return Text(
                    "Login".toUpperCase(),
                  );
                },
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
