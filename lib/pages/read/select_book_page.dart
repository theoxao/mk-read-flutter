import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/book_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/book.dart';

class SelectBookPage extends StatefulWidget {
  final String isbn;
  final SelectedBookBLoc bloc;

  SelectBookPage({Key key, this.isbn, this.bloc}) : super(key: key);

  @override
  _SelectBookPageState createState() => _SelectBookPageState();
}

class _SelectBookPageState extends State<SelectBookPage> {
  BookSearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = BookSearchBloc(widget.isbn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchBloc.initData(widget.isbn);
    return Scaffold(
      appBar: AppBar(
        title: Text("选择图书"),
      ),
      body: StreamBuilder(
        stream: searchBloc.stream,
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            List<Book> list = snapshot.data;
            List<Widget> cols = [Center(child: Text("通过${widget.isbn}找到以下书籍"))];
            cols.addAll(list.map((book) {
              return bookView(book);
            }).toList());
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: cols),
            );
          } else {
            return Container(
              child: Center(child: Text("未找到任何书籍，请尝试手动添加")),
            );
          }
        },
      ),
    );
  }

  Widget bookView(Book book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          widget.bloc.sink.add(book);
          Navigator.of(context).pop();
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Image.network(
                  book.cover,
                  width: coverWidth / 2,
                  height: coverHeight / 2,
                  fit: BoxFit.cover,
                  scale: coverWidth / coverHeight,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        book.name,
                        style: bookNameStyle,
                      ),
                      Text(
                        book.author + book.publisher,
                        style: bookAuthorStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
