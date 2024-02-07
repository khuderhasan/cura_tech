import '../../../../config/constants.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/auth_cubit/auth_state.dart';
import '../../../cubits/staff_cubit/staff_cubit.dart';
import '../../../cubits/staff_cubit/staff_state.dart';
import '../components/patient_drawer.dart';
import '../../welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PatientDrawer(),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocListener<AuthCubit, RegisterState>(
        listener: (context, state) {
          if (state is SuccessSignOutRegisterState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
              ..showSnackBar(const SnackBar(
                content: Text("Signed Out Successfully"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          }
        },
        child: BlocConsumer<StaffCubit, StaffState>(
          bloc: context.read<StaffCubit>()..fetchProfileData(),
          listener: (context, state) {
            if (state is ErrorStaffState) {
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
          builder: (context, state) {
            if (state is LoadedProfileDataState) {
              return Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* Name TextField
                    const Icon(
                      Icons.person,
                      size: 150,
                      color: kPrimaryColor,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      cursorColor: kPrimaryColor,
                      onSaved: (name) {},
                      decoration: InputDecoration(
                        hintText: "Name : ${state.data.fullName} ",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),

                    //* Email TextField
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        enabled: false,
                        onSaved: (email) {},
                        decoration: InputDecoration(
                          hintText: "Email : ${state.data.email}",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      cursorColor: kPrimaryColor,
                      onSaved: (name) {},
                      decoration: InputDecoration(
                        hintText: "Gender : ${state.data.gender} ",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        enabled: false,
                        cursorColor: kPrimaryColor,
                        onSaved: (name) {},
                        decoration: InputDecoration(
                          hintText: "Account Type : ${state.data.accountType} ",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<AuthCubit>().signOut();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            color: errorColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "LogOUt".toUpperCase(),
                            style: const TextStyle(color: errorColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
