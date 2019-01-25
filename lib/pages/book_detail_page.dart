import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/views/book_detail_card.dart';
import 'package:flutter_mk/views/book_stat_card.dart';

class BookDetailPage extends StatefulWidget {
  final UserBook userBook;

  BookDetailPage(this.userBook);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userBook.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            BookDetailCard(widget.userBook),
            BookStatCard(widget.userBook),
          ],
        ),
      ),
    );
  }
}
