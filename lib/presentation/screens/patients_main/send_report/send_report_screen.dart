import '../../../../config/constants.dart';
import '../../../cubits/patient_cubit/patient_cubit.dart';
import '../components/patient_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendReportScreen extends StatefulWidget {
  const SendReportScreen({super.key});

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future sendReport() async {
    FocusNode().unfocus();
    if (_contentController.text.isNotEmpty) {
      await context
          .read<PatientCubit>()
          .sendReport(content: _contentController.text)
          .then((_) => _contentController.clear());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is SuccessSendReportState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Report Sent Successfylly"),
                  Icon(Icons.check_sharp),
                ],
              ),
              backgroundColor: Colors.green,
            ));
        } else if (state is ErrorPatientState) {
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
          title: const Text('Send Report'),
          centerTitle: true,
        ),
        drawer: const PatientDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  'Please Enter your Reort Content to be reviwed by our staff',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  label: const Text('Content'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.assignment_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              BlocBuilder<PatientCubit, PatientState>(
                builder: (context, state) {
                  if (state is LoadingPatientsState) {
                    return const CircularProgressIndicator();
                  }
                  return TextButton.icon(
                    onPressed: () async {
                      await sendReport();
                    },
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Send Report',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
