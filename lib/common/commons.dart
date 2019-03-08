import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String get host => "http://www.theoxao.com:8888";


Options get getOptions {
    Map<String, dynamic> headers = Map();
    headers['token'] = "70843bc3-794a-4d99-a05a-c4e6487036bd";
    var _options = Options(headers: headers);
    return _options;
}

Options getOption(String path){
    var options = getOptions;
    options.path=path;
    print("requesting at $path");
    return options;
}

get primaryColor => Colors.blue;

get accentColor => Colors.teal;

get colorWhite => Colors.white;

get colorDivider => Colors.white70;

double get primaryTextSize => 18;

double get secondTextSize => 16;

double get thirdTextSize => 14;

double get padding4 => 4;

double get padding8 => 8;

double get padding12 => 12;

double get padding16 => 16;

double get padding32 => 32;


double get coverScale => coverWidth / coverHeight;

double get coverWidth => 95;

double get coverHeight => 135;

TextStyle get bookNameStyle =>
        TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: primaryTextSize,
                color: Colors.black,
                decoration: TextDecoration.none);

TextStyle get bookAuthorStyle =>
        TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: primaryTextSize,
                color: Colors.black54,
                decoration: TextDecoration.none);
