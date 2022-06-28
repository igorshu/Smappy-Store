part of 'smappy_bloc.dart';

@freezed
class SmappyEvent with _$SmappyEvent {
  const factory SmappyEvent.error({required String error}) = SmappyError;
  const factory SmappyEvent.changeSmappyCode({required String code}) = ChangeSmappyCode;
  const factory SmappyEvent.changeEmail({required String email}) = ChangeEmail;
  const factory SmappyEvent.changePhone({required String phone}) = ChangePhone;
  const factory SmappyEvent.changeCatalog({required String catalog}) = ChangeCatalog;
  const factory SmappyEvent.checkSmappyCode() = CheckSmappyCode;
  const factory SmappyEvent.sendEmail() = SendEmail;
}