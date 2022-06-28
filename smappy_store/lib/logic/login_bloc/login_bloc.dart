import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginState()) {
    on<ChangePasswordVisibility>(_changePasswordVisibility);
    on<ChangePhone>(_changePhone);
    on<ChangePassword>(_changePassword);
  }

  _changePasswordVisibility(ChangePasswordVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordVisible: event.visible));
  }

  _changePhone(ChangePhone event, Emitter<LoginState> emit) {
    emit(state.copyWith(phoneEmpty: event.phone.isEmpty));
  }

  _changePassword(ChangePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordEmpty: event.password.isEmpty));
  }
}
