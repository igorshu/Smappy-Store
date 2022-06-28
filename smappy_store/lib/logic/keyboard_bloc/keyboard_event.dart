part of 'keyboard_bloc.dart';

@freezed
class KeyboardEvent with _$KeyboardEvent {
  const factory KeyboardEvent.changeKeyboardVisibility(bool visible) = ChangeKeyboardVisibility;
}