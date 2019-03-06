

String formatDateStr(String date) {
  DateTime moonLanding = DateTime.parse(date);
  return '${moonLanding.year}-${moonLanding.month}-${moonLanding.day}';
}