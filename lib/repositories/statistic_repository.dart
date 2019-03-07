import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:dio/dio.dart';

Future<List<Coordinate>> fetchStat()async{
    print("request stat data ");
    String path = host +"/read/read/chart_stat?type=0";
    var response = await Dio(getOptions).get(path);
    List<Coordinate> list =  [];
    for (var data in response.data["data"]){
        list.add(Coordinate.fromJsonMap(data));
    }
    return list;
}