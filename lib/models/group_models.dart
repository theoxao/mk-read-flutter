class Group {

    String id;
    String name;
    String remark;
    String image;
    int type;
    int memberCount;
    List<Members> members;
    bool owner;
    int messageCount;

    Group.fromJsonMap(Map<String, dynamic> map)
            :
                id = map["id"],
                name = map["name"],
                remark = map["remark"],
                image = map["image"],
                type = map["type"],
                memberCount = map["memberCount"],
                members = List < Members>.  from   (   map   ["members" ]      . map ( ( it ) =>  Members.fromJsonMap(it)  )    )   ,

    owner    =   map  ["owner" ] ,
    messageCount=   map ["messageCount" ];

}


class Members {

    String userId;
    String displayName;
    String nickName;
    int role;
    String avatarUrl;
    bool owner;

    Members.fromJsonMap(Map<String, dynamic> map)
            :
                userId = map["userId"],
                displayName = map["displayName"],
                nickName = map["nickName"],
                role = map["role"],
                avatarUrl = map["avatarUrl"],
                owner = map["owner"];

}
