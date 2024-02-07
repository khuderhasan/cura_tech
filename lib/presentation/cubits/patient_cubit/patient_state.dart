part of 'patient_cubit.dart';

abstract class PatientState<T> {
  factory PatientState.empty() = EmptyPatientState<T>;

  factory PatientState.loading() = LoadingPatientsState<T>;

  factory PatientState.loadedNeighbors(List<Patient> data) =
      LoadedNeighborsState<T>;

  factory PatientState.successSendReport() = SuccessSendReportState<T>;

  factory PatientState.error(ErrorModel error) = ErrorPatientState<T>;

  factory PatientState.loadedProfileDataState(UserModel data) =
      LoadedProfileDataState<T>;
}

class EmptyPatientState<T> implements PatientState<T> {
  const EmptyPatientState();
}

class LoadingPatientsState<T> implements PatientState<T> {
  const LoadingPatientsState();
}

class LoadedNeighborsState<T> implements PatientState<T> {
  final List<Patient> data;
  const LoadedNeighborsState(this.data);
}

class SuccessSendReportState<T> implements PatientState<T> {
  const SuccessSendReportState();
}

class ErrorPatientState<T> implements PatientState<T> {
  final ErrorModel error;
  const ErrorPatientState(this.error);
}

class LoadedProfileDataState<T> implements PatientState<T> {
  final UserModel data;
  const LoadedProfileDataState(this.data);
}
