part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String msg;
  final String image;
  final Status loginState;
  final Status logoutState;
  final Status registerState;
  final Status confirmCodeState;
  final Status resetPasswordState;
  final Status confirmEmailState;
  final Status forgetPasswordState;
  final ErrorType errorType;

  const AuthState({
    this.msg = '',
    this.image = '',
    this.loginState = Status.initial,
    this.logoutState = Status.initial,
    this.registerState = Status.initial,
    this.confirmCodeState = Status.initial,
    this.resetPasswordState = Status.initial,
    this.confirmEmailState = Status.initial,
    this.forgetPasswordState = Status.initial,
    this.errorType = ErrorType.non,
  });

  AuthState copyWith({
    String? msg,
    String? image,
    Status? loginState,
    Status? logoutState,
    Status? registerState,
    Status? confirmCodeState,
    Status? resetPasswordState,
    Status? confirmEmailState,
    Status? forgetPasswordState,
    ErrorType? errorType,
  }) =>
      AuthState(
        msg: msg ?? this.msg,
        image: image ?? this.image,
        loginState: loginState ?? this.loginState,
        logoutState: logoutState ?? this.logoutState,
        errorType: errorType ?? this.errorType,
        registerState: registerState ?? this.registerState,
        confirmCodeState: confirmCodeState ?? this.confirmCodeState,
        resetPasswordState: resetPasswordState ?? this.resetPasswordState,
        confirmEmailState: confirmEmailState ?? this.confirmEmailState,
        forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
      );

  @override
  List<Object> get props => [
        msg,
        image,
        loginState,
        logoutState,
        registerState,
        confirmCodeState,
        resetPasswordState,
        confirmEmailState,
        forgetPasswordState,
        errorType,
      ];
}
