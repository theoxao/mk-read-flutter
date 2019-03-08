import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class EventRequest {
  final BuildContext context;

  EventRequest(this.context);

  Future<Response> get(Options options) async {
    try {
      Response response = await Dio(options).get(options.path);
      return response.data;
    } on DioError catch (e) {
      FlushbarHelper.createError(message: e.toString());
      return null;
    }
  }

  Future<Response> post(Options options) async {
    try {
      Response response = await Dio(options).post(options.path);
      return response;
    } on DioError catch (e) {
      FlushbarHelper.createError(message: e.toString());
      return null;
    }
  }
}
