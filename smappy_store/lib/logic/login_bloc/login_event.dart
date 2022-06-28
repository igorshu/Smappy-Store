part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.changePasswordVisibility(bool visible) = ChangePasswordVisibility;
  const factory LoginEvent.changePhone(String phone) = ChangePhone;
  const factory LoginEvent.changePassword(String password) = ChangePassword;
}