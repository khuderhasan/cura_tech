import '../../../data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/result_class.dart';
import '../../../data/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(const EmptyRegisterState());

  Future<void> signUp(
      {required fullName,
      required email,
      required password,
      required gender,
      required accountType}) async {
    emit(const LoadingRegisterState());
    await authRepository
        .signUp(
            fullName: fullName,
            email: email,
            password: password,
            gender: gender,
            accountType: accountType)
        .then((value) {
      if (value is SuccessState<UserModel>) {
        emit(SuccessRegisterState(value.data));
      } else if (value is ErrorState<UserModel>) {
        emit(ErrorRegisterState(value.error));
      }
    });
  }

  Future<void> signIn({required email, required password}) async {
    emit(const LoadingRegisterState());
    await authRepository.signIn(email: email, password: password).then((value) {
      if (value is SuccessState<UserModel>) {
        emit(SuccessRegisterState(value.data));
      } else if (value is ErrorState<UserModel>) {
        emit(ErrorRegisterState(value.error));
      }
    });
  }

  Future<void> signOut() async {
    emit(const LoadingRegisterState());
    await authRepository.signOut().then((value) {
      if (value is SuccessState<bool>) {
        emit(const SuccessSignOutRegisterState());
      } else if (value is ErrorState<bool>) {
        emit(ErrorRegisterState(value.error));
      }
    });
  }

  Future<void> resetPassword({required email}) async {
    emit(const LoadingRegisterState());
    await authRepository.resetPassword(email: email).then((value) {
      if (value is SuccessState<bool>) {
        emit(const EmptyRegisterState());
      } else if (value is ErrorState<bool>) {
        emit(ErrorRegisterState(value.error));
      }
    });
  }
}
