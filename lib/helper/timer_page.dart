import 'package:flutter/material.dart';
import 'dart:async';

class ElapsedTime {
  final int seconds;
  final int minutes;
  final int hours;

  ElapsedTime({
    this.seconds,
    this.minutes,
    this.hours,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle =
      const TextStyle(fontSize: 90.0, fontFamily: "Bebas Neue");
  final int timerMillisecondsRefreshRate = 1000;
  int startAt = 0;
  int duration = 0;
  Dependencies({this.startAt ,this.duration});
}

class TimerPage extends StatefulWidget {
  TimerPage({Key key, this.dependencies}) : super(key: key);
  final Dependencies dependencies;

  TimerPageState createState() => new TimerPageState(dependencies);
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies;
  int initTime;

  TimerPageState(this.dependencies);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Expanded(
          child: new TimerText(
            dependencies: dependencies,
          ),
        ),
      ],
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});

  final Dependencies dependencies;

  TimerTextState createState() =>
      new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});

  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    milliseconds = dependencies.startAt;
    timer = new Timer.periodic(
        new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != DateTime.now().millisecondsSinceEpoch - dependencies.startAt + dependencies.duration) {
      milliseconds =  DateTime.now().millisecondsSinceEpoch - dependencies.startAt + dependencies.duration;
      final int seconds = (milliseconds / 1000).truncate();
      final int minutes = (seconds / 60).truncate();
      final int hours = (minutes / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        seconds: seconds,
        minutes: minutes,
        hours: hours,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
//    dependencies.stopwatch.start();
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RepaintBoundary(
          child: new SizedBox(
            height: 72.0,
            child: new MinutesAndSeconds(dependencies: dependencies),
          ),
        ),
        new RepaintBoundary(
          child: new SizedBox(
            height: 72.0,
            child: new Hundreds(
              dependencies: dependencies,
            ),
          ),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});

  final Dependencies dependencies;

  MinutesAndSecondsState createState() =>
      new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});

  final Dependencies dependencies;

  int minutes = 0;
  int hours = 0;

  @override
  void initState() {
    var milliseconds = DateTime.now().millisecondsSinceEpoch - dependencies.startAt + dependencies.duration;
    var seconds = (milliseconds / 1000).truncate();
    minutes = (seconds / 60).truncate();
    hours = (minutes / 60).truncate();
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.hours != hours) {
      setState(() {
        minutes = elapsed.minutes;
        hours = elapsed.hours;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String hoursStr = hours.toString();
    return new Text('$hoursStr:$minutesStr:', style: dependencies.textStyle);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});

  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});

  final Dependencies dependencies;
  int seconds = 0;

  @override
  void initState() {
    var milliseconds = DateTime.now().millisecondsSinceEpoch - dependencies.startAt + dependencies.duration;
    seconds = (milliseconds / 1000).truncate();
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.seconds != seconds) {
      setState(() {
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text(secondsStr, style: dependencies.textStyle);
  }
}
