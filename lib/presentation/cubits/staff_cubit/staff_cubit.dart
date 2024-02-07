import '../../../data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/result_class.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/models/report_model.dart';
import '../../../data/repository/staff_repository.dart';
import 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  final StaffRepository staffRepository;
  StaffCubit({required this.staffRepository}) : super(const EmptyStaffState());

  Future<void> fetchPatients() async {
    emit(const LoadingStaffState());
    await staffRepository.fetchPatients().then((value) {
      if (value is SuccessState<List<Patient>>) {
        emit(LoadedPatientsState(value.data));
      } else if (value is ErrorState<List<Patient>>) {
        emit(ErrorStaffState(value.error));
      }
    });
  }

  Future<void> fetchReports() async {
    emit(const LoadingStaffState());
    await staffRepository.fetchReports().then((value) {
      if (value is SuccessState<List<Report>>) {
        emit(LoadedReportsState(value.data));
      } else if (value is ErrorState<List<Report>>) {
        emit(ErrorStaffState(value.error));
      }
    });
  }

  Future<void> deleteReport(String reportId) async {
    emit(const LoadingStaffState());
    await staffRepository.deleteReport(reportId: reportId).then((value) {
      if (value is SuccessState<bool>) {
        fetchReports();
      } else if (value is ErrorState<bool>) {
        emit(ErrorStaffState(value.error));
      }
    });
  }

  Future<void> changeHealthStatus(
      String patientId, String newHealthStatus) async {
    await staffRepository
        .changeHealthStatus(
            patientId: patientId, newHealthStatus: newHealthStatus)
        .then((value) {
      if (value is SuccessState<bool>) {
        emit(const SuccessChangeHealthStatus());
        fetchPatients();
      } else if (value is ErrorState<bool>) {
        emit(ErrorStaffState(value.error));
      }
    });
  }

  Future<void> fetchProfileData() async {
    emit(const LoadingStaffState());
    await staffRepository.fetchProfileData().then((value) {
      if (value is SuccessState<UserModel>) {
        emit(LoadedProfileDataState(value.data));
      } else if (value is ErrorState<UserModel>) {
        emit(ErrorStaffState(value.error));
      }
    });
  }
}
