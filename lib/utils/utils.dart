String getYesterdayString() {
  final DateTime now = new DateTime.now();
  final DateTime date = now.subtract(new Duration(days: now.hour < 12 ? 2 : 1));
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

String getFormatNumber(int number) {
  return number < 1000 ? '$number' : '${(number / 1000.0).toStringAsFixed(1)}K';
}