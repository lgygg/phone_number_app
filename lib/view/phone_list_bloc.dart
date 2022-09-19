import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phone_number_app/common/db_helper.dart';
import 'package:phone_number_app/model/bean/phone_info.dart';
import 'package:sqflite/sqflite.dart';

part 'phone_list_event.dart';
part 'phone_list_state.dart';

class PhoneListBloc extends Bloc<PhoneListEvent, PhoneListState> {
  PhoneListBloc() : super(PhoneListState().init()) {
    on<PhoneListInitEvent>(_init);
  }

  void _init(PhoneListEvent event, Emitter<PhoneListState> emit) async{
    Database db = await DbHelper.instance.openDB();
    await db.query("NumberTable").then((value) async {

      List<PhoneInfo> childList = [];
      if (value.isNotEmpty) {
        value.forEach((item) {
          childList.add(PhoneInfo.fromMap(item));
          print(item.toString());
        });
      }
      await db.close();
      state.phoneList = childList;
      emit(state.clone());
    });
  }
}
