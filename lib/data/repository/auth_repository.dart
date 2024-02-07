import '../models/user_model.dart';

import '../../config/result_class.dart';
import '../datasource/auth_datasource.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  Future<ResponseState<UserModel>> signUp({
    required fullName,
    required email,
    required password,
    required gender,
    required accountType,
  }) async {
    final userData = await _dataSource.signUp(
        fullName: fullName,
        email: email,
        password: password,
        gender: gender,
        accountType: accountType);
    return userData;
  }

  Future<ResponseState<UserModel>> signIn(
      {required email, required password}) async {
    final userData = await _dataSource.signIn(email: email, password: password);
    return userData;
  }

  Future<ResponseState<bool>> signOut() async {
    final response = await _dataSource.signOut();
    return response;
  }

  Future<ResponseState<bool>> resetPassword({required email}) async {
    final response = await _dataSource.resetPassword(email: email);
    return response;
  }
}
