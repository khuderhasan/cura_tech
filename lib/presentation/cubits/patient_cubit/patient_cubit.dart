import 'dart:convert';

import '../../../config/result_class.dart';
import '../../../data/repository/patient_repository.dart';
import '../../../services/local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/error_model.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/models/user_model.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepository patientRepository;
  PatientCubit({required this.patientRepository})
      : super(const EmptyPatientState());

  Future<void> fetchProfileData() async {
    emit(const LoadingPatientsState());
    await patientRepository.fetchProfileData().then((value) {
      if (value is SuccessState<UserModel>) {
        emit(LoadedProfileDataState(value.data));
      } else if (value is ErrorState<UserModel>) {
        emit(ErrorPatientState(value.error));
      }
    });
  }

  Future<void> sendReport({required content}) async {
    emit(const LoadingPatientsState());
    await patientRepository.sendReport(content: content).then((value) {
      if (value is SuccessState<bool>) {
        emit(const SuccessSendReportState());
      } else if (value is ErrorState<bool>) {
        emit(ErrorPatientState(value.error));
      }
    });
  }

  Future<void> fetchNeighborPatients() async {
    await patientRepository.fetchNeighborPatients().then((value) {
      if (value is SuccessState<List<Patient>>) {
        if (value.data.isNotEmpty) {
          List<Map<String, dynamic>> patientsMapsList = [];
          for (var patient in value.data) {
            patientsMapsList.add(Patient(
                    id: patient.id,
                    fullName: patient.fullName,
                    healthStatus: patient.healthStatus,
                    email: patient.email,
                    lat: patient.lat,
                    long: patient.long)
                .toMap());
          }
          final encodedPatientsList = json.encode(patientsMapsList);
          LocalNotification.showNotification(
              title: 'Hey!',
              body:
                  "You have ${value.data.length} neighbor patients click to see where the are !",
              payload: encodedPatientsList);
        }
      } else if (value is ErrorState<List<Patient>>) {
        emit(ErrorPatientState(value.error));
      }
    });
  }
}
