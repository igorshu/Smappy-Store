import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';

part 'smappy_bloc.freezed.dart';
part 'smappy_event.dart';
part 'smappy_state.dart';

class SmappyBloc extends BaseBloc<SmappyEvent, SmappyState>  {

  @override
  SmappyEvent getErrorEvent(String error) => SmappyError(error: error);

  SmappyBloc() : super(SmappyState()) {
    on<SmappyError>(_smappyError);
    on<ChangeSmappyCode>(_changeSmappyCode);
    on<CheckSmappyCode>(_checkSmappyCode);
    on<ChangeEmail>(_changeEmail);
    on<ChangePhone>(_changePhone);
    on<ChangeCatalog>(_changeCatalog);
    on<SendEmail>(_sendEmail);
  }

  _smappyError(SmappyError event, Emitter<SmappyState> emit) {
    emit(state.copyWith(error: event.error, loading: false));
  }

  _changeSmappyCode(ChangeSmappyCode event, Emitter<SmappyState> emit) {
    emit(state.copyWith(code: event.code));
  }

  _checkSmappyCode(CheckSmappyCode event, Emitter<SmappyState> emit) async {
    emit(state.copyWith(loading: true));
    await ApiRepo.checkSmappyCode(smappyCode: state.code);
    emit(state.copyWith(codeIsOk: true));
  }

  _changeEmail(ChangeEmail event, Emitter<SmappyState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _changePhone(ChangePhone event, Emitter<SmappyState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  _changeCatalog(ChangeCatalog event, Emitter<SmappyState> emit) {
    emit(state.copyWith(catalog: event.catalog));
  }

  _sendEmail(SendEmail event, Emitter<SmappyState> emit) async {
    sendEmail(
      recipient: 'stores@smappy.co',
      subject: 'Smappy',
      text: 'Email: ${state.email}\n'
        'Phone: ${state.phone}\n'
        'Catalog: ${state.catalog}\n'
    );
  }
}
