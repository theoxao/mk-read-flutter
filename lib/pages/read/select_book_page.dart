import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/book_bloc.dart';
import 'package:flutter_mk/models/book.dart';

class SelectBookPage extends StatefulWidget {
  final String isbn;

  const SelectBookPage({Key key, this.isbn}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isbn),
      ),
      body: Container(
          color: Colors.white,
          child: StreamBuilder(
            stream: searchBloc.stream,
            builder: (context, AsyncSnapshot<List<Book>> snapshot) {
              if (snapshot.hasData) {
                List<Book> list = snapshot.data;
                return ListView(
                  children: list.map((book) {}).toList(),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }

  Widget bookView(Book book) {
    return Text(book.name);
  }
}
