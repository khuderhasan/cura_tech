import '../../../config/constants.dart';
import '../../cubits/patient_cubit/patient_cubit.dart';
import 'components/patient_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      bloc: context.read<PatientCubit>()..fetchNeighborPatients(),
      listener: (context, state) {
        if (state is ErrorPatientState) {
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cura Tech App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Cura Tech ",
              style: GoogleFonts.aclonica(fontSize: 20),
            ),
            Image.asset('assets/images/welcome_image.png'),
          ],
        ),
        drawer: const PatientDrawer(),
      ),
    );
  }
}
