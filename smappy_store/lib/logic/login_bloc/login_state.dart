part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {

  factory LoginState({
    @Default(false) bool passwordVisible,
    @Default(true) bool phoneEmpty,
    @Default(true) bool passwordEmpty,
  }) = _LoginState;

}