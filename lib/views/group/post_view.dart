import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/helper/hero_dialog_route.dart';
import 'package:flutter_mk/models/post_model.dart';
import 'package:flutter_mk/repositories/group_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostView extends StatefulWidget {
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState(post);
}

class _PostViewState extends State<PostView> {
  _PostViewState(this.post) : liked = post.liked;

  Post post;
  var liked;

  @override
  Widget build(BuildContext context) {
    var array = [];
    var list = post.images.map((url) {
      var isGif = url.endsWith("gif");
      return GestureDetector(
        onTap: () {
          Navigator.push(context, HeroDialogRoute((context) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.black,
                child: Hero(
                  tag: url,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    placeholder: (context, url) {
                      return SpinKitThreeBounce(
                        color: primaryColor,
                        size: primaryTextSize,
                      );
                    },
                  ),
                ),
              ),
            );
          }));
        },
        child: Container(
          width: window.physicalSize.width / 12,
          height: window.physicalSize.width / 12,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Hero(
              tag: url,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: url + "?x-oss-process=style/" + defaultCompress,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return SpinKitThreeBounce(
                        color: primaryColor,
                        size: primaryTextSize,
                      );
                    },
                  ),
                  isGif
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            " GIF ",
                            style: TextStyle(backgroundColor: Colors.white54),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
    for (var i = 0; i < list.length; i += 3) {
      var value =
          list.sublist(i, i + 3 < list.length ? i + 3 : list.length).toList();
      array.add(value);
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 36,
                child: CachedNetworkImage(
                  imageUrl: post.avatarUrl,
                  height: 36,
                  width: 36,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  width: window.physicalSize.width / 3.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.nickName,
                        style: linkStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              post.content,
                              softWrap: true,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: bookNameStyle,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: array.map((rows) {
                          return Row(
                            children: rows,
                          );
                        }).toList(),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              post.timeDisplay,
                              style: bookNameStyle,
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          GestureDetector(
                            onTap: () {
                              GroupRepository(context)
                                  .likeOperate(post.id, post.liked ? 0 : 1);
                              setState(() {
                                post.liked = !post.liked;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.thumb_up,
                                color: post.liked ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.question_answer),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Card(
                            child: Text(post.likeList.join(",")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
