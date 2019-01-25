import 'package:flutter/material.dart';
import 'package:flutter_mk/pages/book_detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/user_book.dart';
import '../common/commons.dart';

class ShelfBookView extends StatelessWidget {
  final UserBook userBook;

  ShelfBookView(this.userBook);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BookDetailPage(userBook);
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: userBook.cover,
              child: Card(
                elevation: 1,
                shape: Border(),
                child: Image.network(
                  userBook.cover,
                  fit: BoxFit.cover,
                  width: coverWidth,
                  height: coverHeight,
                  scale: 80.0 / 110.0,
//            fit: BoxFit.fill,
                ),
              ),
            ),
            Hero(
              tag: userBook.name,
              child: Text(
                userBook.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: bookNameStyle,
              ),
            ),
            Hero(
              tag: userBook.author,
              child: Text(
                userBook.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: bookAuthorStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
