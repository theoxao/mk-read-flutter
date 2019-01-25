import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

get primaryColor => Colors.blue;

get accentColor => Colors.teal;

get colorWhite => Colors.white;

get colorDivider => Colors.white70;

double get primaryTextSize => ScreenUtil.instance.setWidth(16);

double get secondTextSize => ScreenUtil.instance.setWidth(14);

double get thirdTextSize => ScreenUtil.instance.setWidth(12);

double get padding8 => ScreenUtil.instance.setWidth(8);

double get padding12 => ScreenUtil.instance.setWidth(12);

double padding(int size) => ScreenUtil.instance.setWidth(size);

double get coverScale => 80.0 / 110.0;

double get coverWidth => ScreenUtil.instance.setWidth(80);

double get coverHeight => ScreenUtil.instance.setHeight(110);

TextStyle get bookNameStyle =>
        TextStyle(fontWeight: FontWeight.normal, fontSize: primaryTextSize, color: Colors
                .black, decoration: TextDecoration.none);

TextStyle get bookAuthorStyle =>
        TextStyle(fontWeight: FontWeight.normal, fontSize: secondTextSize, color: Colors
                .black87, decoration: TextDecoration.none);
