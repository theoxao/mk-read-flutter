import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/user_book.dart';
import '../common/commons.dart';

class ShelfBookView extends StatelessWidget {
  final UserBook userBook;

  ShelfBookView(this.userBook);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
                  elevation: 0,
                  child: Image.network(
                    userBook.cover,
                    width: ScreenUtil.instance.setWidth(160),
                    height: ScreenUtil.instance.setWidth(220),
                    scale: 80.0 / 110.0,
//            fit: BoxFit.fill,
                  )),
          Text(
            userBook.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: secondTextSize),
          ),
          Text(
            userBook.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: secondTextSize),
          )
        ],
      ),
    );
  }
}
