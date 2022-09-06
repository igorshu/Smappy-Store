part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {

  const AuthState._();

  bool get isLoggedIn => token.isNotEmpty;
  // bool get isLoggedOut => token.isEmpty && !logging;

  const factory AuthState({
    @Default('') String token,
    @Default('') String error,
    @Default(false) bool logging,
  }) = _AuthStartState;
}