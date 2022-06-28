part of 'registration_bloc.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.error({required String error}) = RegistrationError;
  const factory RegistrationEvent.changePhone(String phone) = ChangePhone;
  const factory RegistrationEvent.changeCode({required String code}) = ChangeCode;
  const factory RegistrationEvent.changePassword(int n, {required String password}) = ChangePassword;
  const factory RegistrationEvent.changePasswordObscurity(bool obscure, int n) = ChangePasswordObscurity;
  const factory RegistrationEvent.changeShopData({String? shopName, String? shopAddress}) = ChangeShopData;
  const factory RegistrationEvent.resendCode() = ResendCode;
  const factory RegistrationEvent.showSecondPassword() = ShowSecondPassword;
  const factory RegistrationEvent.next({
    required RegStep step,
    String? phone,
    String? code,
    String? password1,
    String? password2,
    String? shopName,
    String? shopAddress,
  }) = Next;
}