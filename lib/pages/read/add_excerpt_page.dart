import 'package:flutter/material.dart';
import 'package:flutter_mk/models/user_book.dart';

class AddExcerptPage extends StatefulWidget {
  final  UserBook userBook;

  const AddExcerptPage(this.userBook);

  @override
  _AddExcerptPageState createState() => _AddExcerptPageState();
}

class _AddExcerptPageState extends State<AddExcerptPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
