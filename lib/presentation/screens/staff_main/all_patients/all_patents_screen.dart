import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/auth_cubit/auth_state.dart';
import '../../../cubits/staff_cubit/staff_cubit.dart';
import '../../../cubits/staff_cubit/staff_state.dart';
import '../../welcome/welcome_screen.dart';
import 'components/patient_card.dart';

class AllPatientsScreen extends StatelessWidget {
  const AllPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessSignOutRegisterState) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const WelcomeScreen();
            },
          ));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Text("Signed Out "),
              backgroundColor: errorColor,
            ));
        }
      },
      child: BlocBuilder<StaffCubit, StaffState>(
        bloc: context.read<StaffCubit>()..fetchPatients(),
        builder: (context, state) {
          if (state is LoadedPatientsState) {
            final patients = state.data;
            if (patients.isNotEmpty) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                itemBuilder: (context, index) =>
                    PatientCard(patient: patients[index]),
                itemCount: patients.length,
              );
            }
            return const Center(
              child: Text('No Patients Yet ! '),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
