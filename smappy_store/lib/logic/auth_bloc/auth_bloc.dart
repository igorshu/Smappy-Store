import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {

  @override
  AuthEvent getErrorEvent(String error) => LoginError(error: error);

  AuthBloc() : super(const AuthState()) {
    on<Login>(_login);
    on<LoginError>(_loginError);
  }

  _login(Login event, Emitter<AuthState> emit) async {
    emit(const AuthState(logging: true));
    var loginResponse = await ApiRepo.login(event.phone, event.password);
    await LocalRepo.saveToken(loginResponse.token);
    emit(AuthState(token: loginResponse.token, logging: false));
  }

  _loginError(LoginError event, Emitter<AuthState> emit) {
    emit(AuthState(error: event.error, logging: false));
  }
}
