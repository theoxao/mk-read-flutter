import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/http/request_wrap.dart';
import 'package:flutter_mk/models/music.dart';
import 'package:flutter/material.dart';

class ContentRepository {

    EventRequest request;

    ContentRepository(BuildContext context):this.request = EventRequest(context);

    Future<List<Music>> fetchMusicList() async {
        print("request stat data ");
        String path = host + "/read/music/list";
        var response = await request.get(getOption(path));
        List<Music> list = [];
        print(response.data);
        for (var data in response.data["data"]) {
            list.add(Music.fromJsonMap(data));
        }
        return list;
    }
}