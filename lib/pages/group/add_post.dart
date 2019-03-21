import 'package:flutter/material.dart';

class NewPostPage extends StatefulWidget {
  final groupId;

  const NewPostPage({Key key, this.groupId}) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("新发言"),),
    );
  }
}