String timeParse(int time) {
  var hour = time ~/ (60 * 60 * 1000).floor();
  var minute = (time - hour * 60 * 60 * 1000) ~/ (60 * 1000);
    var second = (time - hour * 60 * 60 * 1000 - minute * 60 * 1000) ~/ 1000;

  String result = "";
  if (hour != 0) {
    result += "$hour小时";
  }
  if (minute != 0) {
    result += "$minute分钟";
  }
  if(hour ==0 && minute == 0)
    result+="$second秒";
  return result;
}
