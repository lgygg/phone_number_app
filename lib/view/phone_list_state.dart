part of 'phone_list_bloc.dart';

class PhoneListState {
  late List<PhoneInfo> phoneList;
  PhoneListState init(){
    return PhoneListState()..phoneList = [];
  }
  PhoneListState clone(){
    return PhoneListState()..phoneList = phoneList;
  }
}
