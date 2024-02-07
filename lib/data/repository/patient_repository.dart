import '../models/patient_model.dart';
import '../models/user_model.dart';

import '../../config/result_class.dart';
import '../datasource/patient_datasource.dart';

class PatientRepository {
  final PatientDataSource _dataSource;

  PatientRepository({required PatientDataSource dataSource})
      : _dataSource = dataSource;

  Future<ResponseState<bool>> sendReport({required content}) async {
    final response = await _dataSource.sendReport(content: content);
    return response;
  }

  Future<ResponseState<List<Patient>>> fetchNeighborPatients() async {
    final response = await _dataSource.fetchNeighborsPatients();
    return response;
  }

  Future<ResponseState<UserModel>> fetchProfileData() async {
    final response = await _dataSource.fetchProfileData();
    return response;
  }
}
