import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/pages/read/read_page.dart';

class BookDetailCard extends StatelessWidget {
  final UserBook userBook;

  BookDetailCard(this.userBook);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border(),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                userBook.name,
                style: bookNameStyle,
              ),
              Text(
                userBook.author,
                style: bookAuthorStyle,
              ),
              Text(
                userBook.createAt.toString(),
                style: TextStyle(fontSize: thirdTextSize),
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return ReadPage("", userBook);
                      }));
                    },
                    child: Text("开始阅读"),
                  ),
                  RaisedButton(
                    onPressed: addNewBook,
                    child: Icon(Icons.add),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }


  void addNewBook() {

  }
}
