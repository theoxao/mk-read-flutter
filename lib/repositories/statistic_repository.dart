import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/http/request_wrap.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class StatRepository {

    EventRequest request;

    StatRepository(BuildContext context):this.request = EventRequest(context);

    Future<List<Coordinate>> fetchStat() async {
        print("request stat data ");
        String path = host + "/read/read/chart_stat?type=0";
        var response = await request.get(getOption(path));
        List<Coordinate> list = [];
        for (var data in response.data["data"]) {
            list.add(Coordinate.fromJsonMap(data));
        }
        return list;
    }
}