import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/helper/my_flushbar_helper.dart';

class EventRequest {
  final BuildContext context;

  EventRequest(this.context);

  Future<Response> get(BaseOptions options) async {
    try {
      print(options.baseUrl);
      Response response = await Dio(options).get(options.baseUrl);
      return response;
    } on DioError catch (e) {
      MyFlushbarHelper.globalNotify(message: "网络请求出错")..show(context);
      return null;
    }
  }

  Future<Response> post(BaseOptions options, {dynamic data}) async {
    try {
      Response response = await Dio(options).post(options.baseUrl, data: data);
      return response;
    } on DioError catch (e) {
      MyFlushbarHelper.globalNotify(message: "网络请求出错")..show(context);
      return Response(data: []);
    }
  }
}
