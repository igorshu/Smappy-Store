part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({required String phone, required String password}) = Login;
  const factory AuthEvent.error({required String error}) = LoginError;
  const factory AuthEvent.updateToken({required String token}) = UpdateToken;
  const factory AuthEvent.logout() = Logout;
}