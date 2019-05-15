import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mk/models/post_model.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var array = [];
    var list = post.images.map((url) {
      return Image.network(
        url+"?x-oss-process=style/compress",
        width: window.physicalSize.width / 9,
        scale: 0.8,
        height: window.physicalSize.width / 9,
        fit: BoxFit.cover,
      );
    }).toList();
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
