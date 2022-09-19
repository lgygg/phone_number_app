
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:phone_number_app/model/bean/area_info.dart';

class MainNet {

  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://country.io',
    // headers: {
    //   HttpHeaders.contentTypeHeader :Headers.formUrlEncodedContentType,
    // },
  ));
  MainNet(){
    init();
  }

  void init() {
    dio.options.connectTimeout = 5000;//超时时间
    dio.options.receiveTimeout = 3000;//接收数据最长时间
    dio.options.contentType=Headers.jsonContentType;
    dio.options.responseType = ResponseType.json;//定制接收的数据类型
  }
  //
  Future<AreaCodeInfo> getAreaCode() async {
    AreaCodeInfo temp = new AreaCodeInfo();
    Response response = await dio.get("http://country.io/phone.json");
    if(response.statusCode==200){
      return AreaCodeInfo.fromMap(response.data);
    }
    return new AreaCodeInfo();
  }
}