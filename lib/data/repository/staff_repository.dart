import '../models/user_model.dart';

import '../../config/result_class.dart';
import '../datasource/staff_datasource.dart';
import '../models/patient_model.dart';
import '../models/report_model.dart';

class StaffRepository {
  final StaffDataSource _dataSource;

  StaffRepository({required StaffDataSource dataSource})
      : _dataSource = dataSource;

  Future<ResponseState<List<Patient>>> fetchPatients() async {
    final response = await _dataSource.fetchPatients();
    return response;
  }

  Future<ResponseState<bool>> changeHealthStatus(
      {required patientId, required newHealthStatus}) async {
    final response = await _dataSource.changeHealthStatus(
        patientId: patientId, newHealthStatus: newHealthStatus);
    return response;
  }

  Future<ResponseState<List<Report>>> fetchReports() async {
    final response = await _dataSource.fetchReports();
    return response;
  }

  Future<ResponseState<bool>> deleteReport({required reportId}) async {
    final response = await _dataSource.deleteReport(reportId: reportId);
    return response;
  }

  Future<ResponseState<UserModel>> fetchProfileData() async {
    final response = await _dataSource.fetchProfileData();
    return response;
  }
}
