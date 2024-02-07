import '../../../data/models/user_model.dart';

import '../../../config/error_model.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/models/report_model.dart';

abstract class StaffState<T> {
  factory StaffState.empty() = EmptyStaffState<T>;

  factory StaffState.loading() = LoadingStaffState<T>;

  factory StaffState.successChangeHealthStatus() = SuccessChangeHealthStatus<T>;

  factory StaffState.loadedProfileDataState(UserModel data) =
      LoadedProfileDataState<T>;

  factory StaffState.loadingFetchingPatients() =
      LoadingFetchingPatinetsState<T>;

  factory StaffState.loadingFetchingReports() = LoadingFetchingReportsState<T>;

  factory StaffState.loadingDeleteReport() = LoadingDeleteReportState<T>;

  factory StaffState.loadedPatients(List<Patient> data) =
      LoadedPatientsState<T>;

  factory StaffState.loadedReports(List<Report> data) = LoadedReportsState<T>;

  factory StaffState.error(ErrorModel error) = ErrorStaffState<T>;
}

class LoadingStaffState<T> implements StaffState<T> {
  const LoadingStaffState();
}

class SuccessChangeHealthStatus<T> implements StaffState<T> {
  const SuccessChangeHealthStatus();
}

class LoadingFetchingPatinetsState<T> implements StaffState<T> {
  const LoadingFetchingPatinetsState();
}

class LoadingFetchingReportsState<T> implements StaffState<T> {
  const LoadingFetchingReportsState();
}

class LoadingDeleteReportState<T> implements StaffState<T> {
  const LoadingDeleteReportState();
}

class EmptyStaffState<T> implements StaffState<T> {
  const EmptyStaffState();
}

class LoadedPatientsState<T> implements StaffState<T> {
  final List<Patient> data;

  const LoadedPatientsState(this.data);
}

class LoadedReportsState<T> implements StaffState<T> {
  final List<Report> data;
  const LoadedReportsState(this.data);
}

class LoadedProfileDataState<T> implements StaffState<T> {
  final UserModel data;
  const LoadedProfileDataState(this.data);
}

class ErrorStaffState<T> implements StaffState<T> {
  final ErrorModel error;
  const ErrorStaffState(this.error);
}
