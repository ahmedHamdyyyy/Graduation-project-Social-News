part of 'user_cubit.dart';

class UserState extends Equatable {
  final String msg;
  final String image;
  final ErrorType error;
  final Status getMyDataState;
  final Status updateMyDataState;
  final Status updatePasswordState;
  final Status deleteMyDataState;
  final Status getUserDataState;
  final Status authenticatePasswordState;
  final UserModel myData;
  final UserModel userData;

  const UserState({
    this.msg = '',
    this.image = '',
    this.error = ErrorType.non,
    this.getMyDataState = Status.initial,
    this.getUserDataState = Status.initial,
    this.updateMyDataState = Status.initial,
    this.updatePasswordState = Status.initial,
    this.deleteMyDataState = Status.initial,
    this.authenticatePasswordState = Status.initial,
    this.myData = UserModel.non,
    this.userData = UserModel.non,
  });

  UserState copyWith({
    String? msg,
    String? image,
    ErrorType? error,
    Status? getMyDataState,
    Status? updateMyDataState,
    Status? updatePasswordState,
    Status? deleteMyDataState,
    Status? getUserDataState,
    Status? authenticatePasswordState,
    UserModel? myData,
    UserModel? userData,
  }) =>
      UserState(
        msg: msg ?? this.msg,
        image: image ?? this.image,
        error: error ?? this.error,
        getMyDataState: getMyDataState ?? this.getMyDataState,
        updateMyDataState: updateMyDataState ?? this.updateMyDataState,
        updatePasswordState: updatePasswordState ?? this.updatePasswordState,
        deleteMyDataState: deleteMyDataState ?? this.deleteMyDataState,
        getUserDataState: getUserDataState ?? this.getUserDataState,
        authenticatePasswordState:
            authenticatePasswordState ?? this.authenticatePasswordState,
        myData: myData ?? this.myData,
        userData: userData ?? this.userData,
      );

  @override
  List<Object> get props => [
        msg,
        image,
        error,
        getMyDataState,
        updateMyDataState,
        updatePasswordState,
        deleteMyDataState,
        getUserDataState,
        authenticatePasswordState,
        myData,
        userData,
      ];
}
