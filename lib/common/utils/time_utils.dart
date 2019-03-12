

String formatDateStr(String date) {
  DateTime moonLanding = DateTime.parse(date);
  return '${moonLanding.year}-${moonLanding.month}-${moonLanding.day}';
}

String getWeekDay(String date) {
  DateTime dateTime = DateTime.parse(date);
  var weekDay = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
  return '${weekDay[dateTime.weekday - 1]}';
}

String getDay(date) {
  DateTime dateTime = DateTime.parse(date);
  String day = dateTime.day.toString();
  return day.length < 2 ? '0$day' : day;
}

String getMonth(date) {
  DateTime dateTime = DateTime.parse(date);
  var months = [
    "一月",
    "二月",
    "三月",
    "四月",
    "五月",
    "六月",
    "七月",
    "八月",
    "九月",
    "十月",
    "十一月",
    "十二月"
  ];
  return '${months[dateTime.month - 1]}';
}