class ReadProgress {
    String id;
    String userBookId;
    int startAt;
    int endAt;
    int status;
    int duration;
    int currentPage;

    ReadProgress.fromJsonMap(Map<String, dynamic> map)
            : id = map["id"],
                userBookId = map["userBookId"],
                startAt = map["startAt"],
                endAt = map["endAt"],
                status = map["status"],
                duration = map["duration"],
                currentPage = map["currentPage"];
}


class ReadExcerpt {

    String id;
    String userId;
    String refBook;
    int refPage;
    String content;
    List<String> images;
    int createAt;

    ReadExcerpt.fromJsonMap(Map<String, dynamic> map)
            :
                id = map["id"],
                userId = map["userId"],
                refBook = map["refBook"],
                refPage = map["refPage"],
                content = map["content"],
                images = List < String>.

    from

    (

    map

    [

    "

    images

    "

    ]

    )

    ,

    createAt

    =

    map

    [

    "

    createAt

    "

    ];

}
