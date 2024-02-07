import '../../../../config/constants.dart';
import '../../../cubits/staff_cubit/staff_cubit.dart';
import '../../../cubits/staff_cubit/staff_state.dart';
import 'components/report_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffCubit, StaffState>(
        bloc: context.read<StaffCubit>()..fetchReports(),
        builder: (context, state) {
          if (state is LoadedReportsState) {
            final reports = state.data;
            if (reports.isNotEmpty) {
              return ListView.builder(
                itemCount: reports.length,
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                itemBuilder: (context, index) =>
                    ReportTile(report: reports[index]),
              );
            }
            return const Center(
              child: Text(
                'No Reports yet !!',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
