import '../../../../../config/constants.dart';
import '../../../../../data/models/patient_model.dart';
import '../../../../cubits/staff_cubit/staff_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    void changeStateDialog() async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Change Health Status',
            style: TextStyle(color: errorColor),
          ),
          content: Text(
            'Do you Want to Change health status To ${(patient.healthStatus == 'Healthy') ? 'Patient' : 'Healthy'}',
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: errorColor),
                    )),
                TextButton(
                    onPressed: () async {
                      await context
                          .read<StaffCubit>()
                          .changeHealthStatus(
                              patient.id,
                              (patient.healthStatus == 'Healthy')
                                  ? 'Patient'
                                  : 'Healthy')
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: const Text(
                      'Confirm',
                    ))
              ],
            )
          ],
        ),
      );
    }

    return Card(
        borderOnForeground: true,
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
            // contentPadding: const EdgeInsets.all(defaultPadding / 2),
            leading: Container(
                margin: const EdgeInsets.only(left: 5),
                height: 130,
                width: 50,
                child: const Icon(Icons.account_circle, size: 55)),
            title: Text(
              patient.fullName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: 'Lato',
              ),
            ),
            subtitle: Text(
              patient.email,
              style: const TextStyle(color: Colors.black),
            ),
            trailing: GestureDetector(
              onTap: changeStateDialog,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kPrimaryColor,
                ),
                child: Text(
                  patient.healthStatus,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )));
  }
}
