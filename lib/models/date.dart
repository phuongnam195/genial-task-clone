class Date {
  final int day;
  final int month;
  final int year;

  Date(this.day, this.month, this.year);
  factory Date.fromDateTime(DateTime datetime) =>
      Date(datetime.day, datetime.month, datetime.year);
  factory Date.fromJson(Map json) =>
      Date(json['day'], json['month'], json['year']);

  Map toJson() => {'day': day, 'month': month, 'year': year};

  DateTime get datetime => DateTime(year, month, day);

  static Date today() => Date.fromDateTime(DateTime.now());
  static Date tomorrow() =>
      Date.fromDateTime(DateTime.now().add(Duration(days: 1)));
  static Date dayAfterTomorrow() =>
      Date.fromDateTime(DateTime.now().add(Duration(days: 2)));

  bool isToday() {
    final today = DateTime.now();
    return (year == today.year && month == today.month && day == today.day);
  }

  bool isTomorrow() {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return (year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day);
  }

  bool isPast() {
    final now = DateTime.now();
    final earlyToday = DateTime(now.year, now.month, now.day);
    return datetime.isBefore(earlyToday);
  }

  // except tomorrow
  bool isFuture() {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    if (year < tomorrow.year) return false;
    if (year > tomorrow.year) return true;
    if (month < tomorrow.month) return false;
    if (month > tomorrow.month) return true;
    return (day > tomorrow.day);
  }

  String toString() {
    String str = '';
    if (day < 10) str += '0';
    str = str + day.toString() + '/';
    if (month < 10) str += '0';
    str = str + month.toString() + '/' + (year % 100).toString();
    return str;
  }

  int difference(Date other) {
    return datetime.difference(other.datetime).inDays;
  }
}
