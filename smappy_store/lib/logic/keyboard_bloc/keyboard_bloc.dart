import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyboard_event.dart';
part 'keyboard_state.dart';

part 'keyboard_bloc.freezed.dart';


class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {

  KeyboardBloc() : super(const KeyboardState()) {
    on<ChangeKeyboardVisibility>(_changeKeyboardVisibility);
  }

  _changeKeyboardVisibility(event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(visible: event.visible));
  }
}
