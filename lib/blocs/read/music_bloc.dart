


import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/music.dart';
import 'package:flutter_mk/repositories/content_repository.dart';

class MusicBloc extends BaseBloc<List<Music>> {
  
  var list ;

  MusicBloc(){
    initData();
      }
    
      void initData() async{
         var list= await  ContentRepository(context).fetchMusicList();
         this.list= list;
         sink.add(list);
      }

}