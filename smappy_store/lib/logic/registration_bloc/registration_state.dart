part of 'registration_bloc.dart';

@freezed
class RegistrationState with _$RegistrationState {

  const RegistrationState._();

  bool get isCompleted => completed;

  factory RegistrationState({
    @Default(RegStep.phone) RegStep step,
    @Default('') String smappyCode,
    @Default(false) bool loading,
    @Default('') String error,
    @Default(false) bool buttonActive,
    @Default(null) String? verificationCode,
    @Default(true) bool password1Obscurity,
    @Default(true) bool password2Obscurity,
    @Default(false) bool bottomBannerTappable,
    @Default('') String phone,
    @Default('') String password1,
    @Default('') String password2,
    @Default(false) bool showPassword2,
    @Default('') String? shopName,
    @Default('') String? shopAddress,
    @Default(null) int? userId,

    @Default(false) bool completed,

  }) = _RegistrationState;
}