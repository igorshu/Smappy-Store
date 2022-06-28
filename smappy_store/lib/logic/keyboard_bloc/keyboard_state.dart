part of 'keyboard_bloc.dart';

@freezed
class KeyboardState with _$KeyboardState {
  const factory KeyboardState({@Default(false) bool visible}) = _KeyboardState;
}