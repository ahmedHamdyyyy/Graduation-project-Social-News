import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants/app_constants/constants.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';
import '../../friends/logic/friends_cubit.dart';
import '../domain/user_repository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());
  final _repository = UserRepository();
  ResponseModel _response = const ResponseModel();

  void get setMyData async {
    emit(state.copyWith(getMyDataState: Status.loading));
    _response = _repository.getMyData;
    emit(state.copyWith(
      getMyDataState: _response.state,
      image: (_response.data as UserModel).image,
      myData: _response.data,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void setUserData(String id) async {
    emit(state.copyWith(getUserDataState: Status.loading));
    _response = await _repository.getUserData(id);
    _response.state == Status.success
        ? FriendsCubit().setFollow((_response.data as UserModel).followings.contains(state.myData.id))
        : null;
    emit(state.copyWith(
      error: _response.error,
      msg: _response.msg,
      userData: _response.data,
      getUserDataState: _response.state,
    ));
  }

  void updateUserData(UserModel user) async {
    emit(state.copyWith(updateMyDataState: Status.loading));
    final response = await _repository.updateUserData(user);
    emit(state.copyWith(
      error: response.error,
      msg: response.msg,
      myData: response.data,
      updateMyDataState: response.state,
    ));
  }

  void updatePassword(String password, String userId) async {
    emit(state.copyWith(updatePasswordState: Status.loading));
    final response = await _repository.updatePassword(password, userId);
    emit(state.copyWith(
      error: response.error,
      msg: response.msg,
      updatePasswordState: response.state,
    ));
  }

  void get deleteUserData async {
    emit(state.copyWith(deleteMyDataState: Status.loading));
    final response = await _repository.deleteUserData(state.myData.id);
    emit(state.copyWith(
      error: response.error,
      msg: response.msg,
      deleteMyDataState: response.state,
    ));
  }

  void get init => emit(state.copyWith(
        deleteMyDataState: Status.initial,
        getMyDataState: Status.initial,
        getUserDataState: Status.initial,
        updateMyDataState: Status.initial,
      ));

  void refreshUserData(String id) {
    emit(state.copyWith(getUserDataState: Status.initial));
    setUserData(id);
  }

  void get refreshProfileData async {
    emit(state.copyWith(getMyDataState: Status.loading));
    _response = await _repository.getUserData(state.myData.id);
    _response.state == Status.success ? _repository.setMyData(_response.data) : null;
    emit(state.copyWith(
      getMyDataState: _response.state,
      error: _response.error,
      msg: _response.msg,
      myData: _response.data,
    ));
  }

  void authenticatePassword(String password) async {
    emit(state.copyWith(authenticatePasswordState: Status.loading));
    _response = await _repository.authenticatePassword(state.myData.email, password);
    emit(state.copyWith(
      authenticatePasswordState: _response.state,
      error: _response.error,
      msg: _response.msg,
    ));
  }

  bool checkUpdatesFound(UserModel user) =>
      state.myData.name != user.name ||
      state.myData.phone != user.phone ||
      state.myData.email != user.email ||
      state.image != user.image;

  void get initAuth => emit(state.copyWith(authenticatePasswordState: Status.initial));
  void get initDelete => emit(state.copyWith(deleteMyDataState: Status.initial));
  void get initUpdatePassword => emit(state.copyWith(updateMyDataState: Status.initial));
  void pickImage(String image) => emit(state.copyWith(image: image));
  void get clearImage => emit(state.copyWith(image: ''));
  String get getProfileImage => state.image;
  UserModel get getProfileData => state.myData;
}
