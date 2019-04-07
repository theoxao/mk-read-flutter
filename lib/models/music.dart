class  Music {
  int id ;
  String name;
  String path;
  
  Music.fromJsonMap(Map<String , dynamic> map)
  :id=map["id"],
  name=map["name"],
  path =map["path"];
}