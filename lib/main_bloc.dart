import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:phone_number_app/model/bean/area_info.dart';
import 'package:phone_number_app/model/bean/phone_info.dart';
import 'package:phone_number_app/model/net/main_net.dart';
import 'package:sqflite/sqflite.dart';

import 'common/db_helper.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainPageState> {
  MainNet mainNet = MainNet();
  MainBloc() : super(MainPageState().init()) {
    on<InitEvent>(_init);
    on<AreaSelectedEvent>(selectAreaCode);
    on<InputEvent>(_inputTextChange);
    on<SaveNumberEvent>(_saveNumber);
  }

  void initDB(){
    //数据库初始化
    List<String> sqls = ["create table NumberTable ("
        "id text primary key,"
        "number text,"
        "areaCode text"
        ")"
      ,];
    DbHelper.instance.initDB("lgy_helper.db",version: 1,sqllist: sqls);
  }

  void _init(InitEvent event, Emitter<MainPageState> emit) async{
    initDB();
    await mainNet.getAreaCode().then((value) {
      state.areaCodeInfo = value;
      emit(state.clone());
    });

  }

  void selectAreaCode(AreaSelectedEvent event, Emitter<MainPageState> emit){
    state.areaCode = event.selectedAreaCode;
    emit(state.clone());
  }

  void _inputTextChange(InputEvent event, Emitter<MainPageState> emit){
    state.inputText = event.inputText;
    emit(state.clone());
  }

  void _saveNumber(SaveNumberEvent event, Emitter<MainPageState> emit) async {
    try {
      Database db = await DbHelper.instance.openDB();
      await db?.insert("NumberTable", event.phoneInfo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await db.close();
      print(event.phoneInfo.toMap().toString());
    } catch (e) {
      debugPrint("error:$e");
    }
  }
}
