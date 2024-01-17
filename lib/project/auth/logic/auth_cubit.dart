import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';
import '../domain/auth_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final _repository = AuthRepository();
  ResponseModel _response = const ResponseModel();

  void login(String mail, String password) async {
    emit(state.copyWith(loginState: Status.loading));
    _response = await _repository.login(mail, password);
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      loginState: _response.state,
    ));
  }

  void get logout async {
    emit(state.copyWith(logoutState: Status.loading));
    _response = await _repository.logout;
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      logoutState: _response.state,
    ));
  }

  void register(UserModel user, String password) async {
    emit(state.copyWith(registerState: Status.loading));
    _response = await _repository.register(user, password);
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      registerState: _response.state,
    ));
  }

  void confirmCode(String code, String email) async {
    emit(state.copyWith(confirmCodeState: Status.loading));
    _response = await _repository.confirmCode(email, code);
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      confirmCodeState: _response.state,
    ));
  }

  void forgetPassword(String email) async {
    emit(state.copyWith(forgetPasswordState: Status.loading));
    _response = await _repository.forgetPassword(email);
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      forgetPasswordState: _response.state,
    ));
  }

  void confirmEmail(String code) async {
    emit(state.copyWith(confirmEmailState: Status.loading));
    _response = await _repository.confirmEmail(code);
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      confirmEmailState: _response.state,
    ));
  }

  void resetPassword(String password, String email) async {
    emit(state.copyWith(resetPasswordState: Status.loading));
    _response = await _repository.resetPassword(password, email);
    emit(state.copyWith(
      errorType: _response.error,
      msg: _response.msg,
      resetPasswordState: _response.state,
    ));
  }

  void get initRegister => emit(state.copyWith(registerState: Status.initial));
  void pickImage(String image) => emit(state.copyWith(image: image));
  void get clearImage => emit(state.copyWith(image: ''));
  String get getImage => state.image;
}
