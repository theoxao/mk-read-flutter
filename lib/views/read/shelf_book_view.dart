import 'package:flutter/material.dart';
import 'package:flutter_mk/pages/read/book_detail_page.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/common/commons.dart';

class ShelfBookView extends StatelessWidget {
  final UserBook userBook;

  ShelfBookView(this.userBook);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BookDetailPage(userBook);
          }));
        },
        child: SizedBox(
          width: 80,
          height: 170,
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
                    scale: coverScale,
//            fit: BoxFit.fill,
                  ),
                ),
              ),
              Hero(
                tag: userBook.name,
                child: SizedBox(
                  width: 95,
                  child: Text(
                    userBook.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bookNameStyle,
                  ),
                ),
              ),
              Hero(
                tag: userBook.author,
                child: SizedBox(
                  width: 95,
                  child: Text(
                    userBook.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bookAuthorStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
