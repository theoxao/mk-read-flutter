import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MyFlushbarHelper {
    static Flushbar globalNotify(
            {@required String message,
                String title,
                Duration duration = const Duration(seconds: 3)}) {
        return Flushbar(flushbarPosition: FlushbarPosition.TOP,forwardAnimationCurve: Curves.elasticInOut,)
            ..title = title
            ..message = message
            ..icon = Icon(
                Icons.warning,
                size: 28.0,
                color: Colors.red[300],
            )
            ..leftBarIndicatorColor = Colors.red[300]
            ..duration = duration
        ;
    }

}
