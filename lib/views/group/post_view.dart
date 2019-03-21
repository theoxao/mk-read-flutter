import 'package:flutter/material.dart';
import 'package:flutter_mk/models/post_model.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.network(post.avatarUrl,height: 20, width: 20,),
            Text(post.nickName),
            Expanded(child: Container()),
            Icon(Icons.more_horiz),
          ],
        ),
        //TODO if ref book exist
        Container(
          color: Colors.white30,
          child: Column(
            children: <Widget>[
              Text(post.content),
              Image.network(post.images[0])
            ],
          ),
        )
      ],
    );
  }
}
