import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/helper/timer_page.dart';

class TimerBloc extends BaseBloc<Dependencies> {
  var dependencies = Dependencies();

  TimerBloc(int startAt , int duration){
    var d= Dependencies(startAt: startAt ,duration: duration);
    this.dependencies = d;
    sink.add(d);
  }

  void stop(){   
    this.dependencies.state=0;
    sink.add(dependencies);
  }

  void start (){
    this.dependencies.state = 1;
    sink.add(dependencies);
  }

}
