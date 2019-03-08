import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/read_detail_models.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class ReadExcerptCard extends StatelessWidget {
  final UserBook userBook;

  const ReadExcerptCard({Key key, this.userBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: Border(),
        child: FutureBuilder(
          future: ReadRepository.fetchReadExcerpt(userBook.id, 1, 3),
          builder: (context, AsyncSnapshot<List<ReadExcerpt>> snapshot) {
            List<Widget> list = [];
            list.add(
              Row(children: <Widget>[Icon(Icons.book), Text("图书摘录")]),
            );
            if (snapshot.connectionState == ConnectionState.done) {
              List<ReadExcerpt> records = snapshot.data;
              if (records != null && records.isNotEmpty) {
                records.forEach((it) {
                  list.add(Divider());
                  list.add(ReadExcerptWidget(record: it));
                });
              }
            } else {
              list.add(SpinKitThreeBounce(
                  color: primaryColor, size: primaryTextSize));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: list,
              ),
            );
          },
        ));
  }
}

class ReadExcerptWidget extends StatelessWidget {
  final ReadExcerpt record;

  const ReadExcerptWidget({Key key, this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(record.content),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceAround,
            children: record.images.map((url) {
              return Image.network(
                url,
                fit: BoxFit.cover,
                width: coverWidth,
                height: coverWidth,
                scale: 1,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
