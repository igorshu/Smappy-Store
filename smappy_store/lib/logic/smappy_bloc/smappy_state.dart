part of 'smappy_bloc.dart';

@freezed
class SmappyState with _$SmappyState {

  factory SmappyState({
    @Default('') String error,
    @Default('') String code,
    @Default(false) bool loading,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String catalog,
    @Default(false) bool codeIsOk,
  }) = _SmappyState;
}