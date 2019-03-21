import 'package:common_utils/common_utils.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/http/request_wrap.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:flutter/material.dart';

class StatRepository {

    EventRequest request;

    StatRepository(BuildContext context):this.request = EventRequest(context);

    Future<List<Coordinate>> fetchStat( int type , int source,  {String
    refBook}) async {
        print("request stat data ");
        String path = host + "/read/read/chart_stat?type=$type&source=$source";
        if (ObjectUtil.isNotEmpty(refBook)){
            path+="&refBook=$refBook";
        }
        var response = await request.get(getOption(path));
        List<Coordinate> list = [];
        print(response.data);
        for (var data in response.data["data"]) {
            list.add(Coordinate.fromJsonMap(data));
        }
        return list;
    }
}