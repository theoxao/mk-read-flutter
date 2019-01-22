import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_mk/models/home_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  PublishSubject<Home> _indexController = PublishSubject();

  Sink<Home> get sink => _indexController.sink;

  Stream<Home> get stream => _indexController.stream;

  @override
  void dispose() {
    _indexController.close();
  }
}
