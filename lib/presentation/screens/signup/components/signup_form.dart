import '../../patients_main/patient_home_screen.dart';
import '../../staff_main/staff_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../../config/validators.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/auth_cubit/auth_state.dart';
import '../../Login/login_screen.dart';
import '../../components/all_ready_have_an_account_chech.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _gender = '';
  String _accountType = '';
  bool _showPass = true;
  Future<void> _trySubmit(BuildContext context) async {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      await context.read<AuthCubit>().signUp(
          fullName: _fullName.trim(),
          email: _email.trim(),
          password: _password.trim(),
          gender: _gender.trim(),
          accountType: _accountType.trim());
    }
  }

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
              builder: (context) => AlertDialog(
                    title: const Text(
                      'Error',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text(state.error.message),
                  ));
        }
      },
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //* Name TextField
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (name) {
                _fullName = name!;
              },
              validator: nameValidator,
              decoration: InputDecoration(
                hintText: "Your Full Name",
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: DropdownButtonFormField<String>(
                hint: const Text('Gender'),
                decoration: InputDecoration(
                  hintText: "Your email",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.man_4_outlined),
                  ),
                ),
                validator: genderValidator,
                onSaved: (gender) {
                  _gender = gender!;
                },
                items: genderDropdownItems,
                onChanged: (value) {
                  _gender = value!;
                },
              ),
            ),
            //* Email TextField
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: emailValidator,
              onSaved: (email) {
                _email = email!;
              },
              decoration: InputDecoration(
                hintText: "Your email",
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            //* Password TextField
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                validator: passwordValidator,
                onSaved: (password) {
                  _password = password!;
                },
                obscureText: _showPass,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
                  suffixIcon: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                        (_showPass) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _showPass = !_showPass;
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
            DropdownButtonFormField<String>(
              hint: const Text('Account Type'),
              decoration: InputDecoration(
                hintText: "Your email",
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.account_box_sharp),
                ),
              ),
              validator: accountTypeValidator,
              onSaved: (accountType) {
                _accountType = accountType!;
              },
              items: accountTypeDropdownItems,
              onChanged: (value) {
                _accountType = value!;
              },
            ),
            const SizedBox(height: defaultPadding),
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
                  return Text("Sign Up".toUpperCase());
                },
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
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
