import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants.dart';
import '../../../../../data/models/report_model.dart';
import '../../../../cubits/staff_cubit/staff_cubit.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({super.key, required this.report});
  final Report report;
  @override
  Widget build(BuildContext context) {
    Future<void> deleteReport() async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Delete Report',
            style: TextStyle(color: errorColor),
          ),
          content: const Text(
            'Do you want to delete this report from the system !? ',
            style: TextStyle(fontSize: 15),
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
                          .deleteReport(report.id)
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
      child: Card(
        borderOnForeground: true,
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        child: ExpansionTile(
          title: Text(report.userName),
          leading: const Icon(Icons.email),
          subtitle: Text(report.userEmail),
          trailing: IconButton(
              onPressed: deleteReport,
              icon: const Icon(
                Icons.delete,
                color: errorColor,
              )),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                'Report : ${report.contnet}',
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
