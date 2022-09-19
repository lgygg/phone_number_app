part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class InitEvent extends MainEvent{
}
class AreaSelectedEvent extends MainEvent{
  final String selectedAreaCode;

  AreaSelectedEvent({required this.selectedAreaCode});
}
class InputEvent extends MainEvent{
  final String inputText;

  InputEvent({required this.inputText});
}
class SaveNumberEvent extends MainEvent{
  final PhoneInfo phoneInfo;
  SaveNumberEvent({required this.phoneInfo});
}