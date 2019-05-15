import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/post_model.dart';
import 'package:flutter_mk/views/group/post_image_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var array = [];
    var list = post.images.asMap().map((index,url) {
      return MapEntry(index, GestureDetector(
        onTap: ()  {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return PostImageView(post.images,index);
          }));
        },
        child: Hero(
          tag: "postImage",
          child: Hero(
            tag: "postImage"+index.toString(),
            child: CachedNetworkImage(
              imageUrl: url + "?x-oss-process=style/compress",
              width: window.physicalSize.width / 9,
              height: window.physicalSize.width / 9,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return SpinKitThreeBounce(
                  color: primaryColor,
                  size: primaryTextSize,
                );
              },
            ),
          ),
        ),
      ));
    }).values.toList();
    for (var i = 0; i < list.length; i += 3) {
      var value =
          list.sublist(i, i + 3 < list.length ? i + 3 : list.length).toList();
      array.add(value);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.network(
                post.avatarUrl,
                height: 20,
                width: 20,
              ),
              Text(post.nickName),
              Expanded(child: Container()),
              Icon(Icons.more_horiz),
            ],
          ),
          //TODO if ref book exist
          Container(
            color: Colors.white30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(post.content),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: array.map((rows) {
                    return Row(
                      children: rows,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
