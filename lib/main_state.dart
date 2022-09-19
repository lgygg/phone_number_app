part of 'main_bloc.dart';

class MainPageState {
  late String areaCode;
  late AreaCodeInfo areaCodeInfo;
  late String inputText;
  MainPageState init(){
    return MainPageState()..areaCode = "852"
    ..areaCodeInfo = AreaCodeInfo()
    ..inputText = "";
  }
  MainPageState clone(){
    return MainPageState()..areaCode = areaCode
    ..areaCodeInfo = areaCodeInfo
    ..inputText = inputText;
  }
}
